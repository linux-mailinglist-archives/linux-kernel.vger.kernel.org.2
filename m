Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847803F2463
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 03:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhHTBnA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Aug 2021 21:43:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:27759 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232564AbhHTBm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 21:42:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="196274145"
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="196274145"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 18:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="522688586"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Aug 2021 18:42:19 -0700
Date:   Fri, 20 Aug 2021 09:36:36 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        David Howells <dhowells@redhat.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [dhowells-fs:netfs-folio-regions 11/28]
 fs/netfs/read_helper.c:979:13: warning: variable 'folio' is uninitialized
 when used here
Message-ID: <20210820013636.GA1702258@pl-dbox>
References: <202108200354.7eThNmGj-lkp@intel.com>
 <YR64CsQVrynR4V/y@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <YR64CsQVrynR4V/y@Ryzen-9-3900X.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 12:59:06PM -0700, Nathan Chancellor wrote:
> On Fri, Aug 20, 2021 at 03:07:06AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-folio-regions
> > head:   215a4ee495a95cc73256ed76f91cb78bcabd6b8e
> > commit: 90417b52931da8cb4eb670c3cc22bfa12aabe55c [11/28] netfs: Use a buffer in netfs_read_request and add pages to it
> > config: hexagon-randconfig-r041-20210818 (attached as .config)
> > compiler: clang version 12.0.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=90417b52931da8cb4eb670c3cc22bfa12aabe55c
> >         git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> >         git fetch --no-tags dhowells-fs netfs-folio-regions
> >         git checkout 90417b52931da8cb4eb670c3cc22bfa12aabe55c
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=hexagon SHELL=/bin/bash fs/netfs/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> fs/netfs/read_helper.c:979:13: warning: variable 'folio' is uninitialized when used here
> >    folio_get(folio);
> >    ^~~~~
> >    fs/netfs/read_helper.c:932:21: note: initialize the variable 'folio' to silence this warning
> >    struct folio
> >    ^
> >    = NULL
> >    fatal error: error in backend: Misaligned constant address: 0x0000001b has alignment 1, but the memory access requires 4
> 
> This crash has been fixed in clang-13 [1]. Philip, would it be possible for
> the robot to use the same clang version for Hexagon that you use for all of the
> other architectures? It should have no issues, as we are using it in our
got it Nathan, we will switch hexagon to the same as other archs today.

> CI. If there are, please let me know so I can try to get them triaged
> and fixed upstream,
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=50838
> 
> Cheers,
> Nathan
> 
> >    PLEASE submit a bug report to https://bugs.llvm.org/ and include the crash backtrace, preprocessed source, and associated run script.
> >    Stack dump:
> >    0. Program arguments: clang -Wp,-MMD,fs/netfs/.read_helper.o.d -nostdinc -isystem /opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/lib/clang/12.0.0/include -Iarch/hexagon/include -I./arch/hexagon/include/generated -Iinclude -I./include -Iarch/hexagon/include/uapi -I./arch/hexagon/include/generated/uapi -Iinclude/uapi -I./include/generated/uapi -include include/linux/compiler-version.h -include include/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__ -Qunused-arguments -fmacro-prefix-map== -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Werror=return-type -Wno-format-security -std=gnu89 --target=hexagon-unknown-linux-musl -integrated-as -Werror=unknown-warning-option -G0 -fno-short-enums -mlong-calls -ffixed-r19 -DTHREADINFO_REG=r19 -D__linux__ -fno-delete-null-pointer-checks -Wno-frame-address -Wno-address-of-packed-member -O2 -Wframe-larger-than=1024 -fno-stack-protector -Wno-format-invalid-specifier -Wno-gnu -mno-global-merge -Wno-unused-const-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -ftrivial-auto-var-init=pattern -fno-stack-clash-protection -falign-functions=64 -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-overflow -fno-stack-check -Werror=date-time -Werror=incompatible-pointer-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunused-const-variable -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limits -I fs/netfs -I ./fs/netfs -DKBUILD_MODFILE="fs/netfs/netfs" -DKBUILD_BASENAME="read_helper" -DKBUILD_MODNAME="netfs" -D__KBUILD_MODNAME=kmod_netfs -c -o fs/netfs/read_helper.o fs/netfs/read_helper.c
> >    1. <eof> parser at end of file
> >    2. Code generation
> >    3. Running pass 'Function Pass Manager' on module 'fs/netfs/read_helper.c'.
> >    4. Running pass 'Hexagon DAG->DAG Pattern Instruction Selection' on function '@netfs_rreq_set_up_buffer'
> >    #0 0x000000000355d1fc llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x355d1fc)
> >    #1 0x000000000355afbe llvm::sys::RunSignalHandlers() (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x355afbe)
> >    #2 0x000000000355c55d llvm::sys::CleanupOnSignal(unsigned long) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x355c55d)
> >    #3 0x00000000034d5aed (anonymous namespace)::CrashRecoveryContextImpl::HandleCrash(int, unsigned long) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x34d5aed)
> >    #4 0x00000000034d5a79 llvm::CrashRecoveryContext::HandleExit(int) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x34d5a79)
> >    #5 0x0000000003557e07 llvm::sys::Process::Exit(int, bool) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3557e07)
> >    #6 0x0000000002107e10 llvm::DenseMapBase<llvm::DenseMap<llvm::AliasSetTracker::ASTCallbackVH, llvm::AliasSetTracker::ASTCallbackVHDenseMapInfo, llvm::detail::DenseMapPair<llvm::AliasSetTracker::ASTCallbackVH, >, llvm::AliasSetTracker::ASTCallbackVH, llvm::AliasSetTracker::ASTCallbackVHDenseMapInfo, llvm::detail::DenseMapPair<llvm::AliasSetTracker::ASTCallbackVH, >::destroyAll() (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2107e10)
> >    #7 0x00000000034da319 llvm::report_fatal_error(llvm::Twine const&, bool) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x34da319)
> >    #8 0x00000000034da3e7 (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x34da3e7)
> >    #9 0x0000000002411b46 (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2411b46)
> >    #10 0x00000000024183c0 llvm::HexagonTargetLowering::LowerLoad(llvm::SDValue, llvm::SelectionDAG&) const (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x24183c0)
> >    #11 0x0000000002419cbb llvm::HexagonTargetLowering::LowerOperation(llvm::SDValue, llvm::SelectionDAG&) const (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2419cbb)
> >    #12 0x00000000042c3b6a (anonymous (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x42c3b6a)
> >    #13 0x00000000042a61af (anonymous (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x42a61af)
> >    #14 0x00000000042a5443 llvm::SelectionDAG::Legalize() (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x42a5443)
> >    #15 0x0000000004375361 llvm::SelectionDAGISel::CodeGenAndEmitDAG() (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x4375361)
> >    #16 0x0000000004373545 llvm::SelectionDAGISel::SelectAllBasicBlocks(llvm::Function const&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x4373545)
> >    #17 0x00000000043703b7 llvm::SelectionDAGISel::runOnMachineFunction(llvm::MachineFunction&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x43703b7)
> >    #18 0x00000000024690c4 llvm::HexagonDAGToDAGISel::runOnMachineFunction(llvm::MachineFunction&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x24690c4)
> >    #19 0x000000000290c1bd llvm::MachineFunctionPass::runOnFunction(llvm::Function&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x290c1bd)
> >    #20 0x0000000002d6a745 llvm::FPPassManager::runOnFunction(llvm::Function&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2d6a745)
> >    #21 0x0000000002d70c51 llvm::FPPassManager::runOnModule(llvm::Module&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2d70c51)
> >    #22 0x0000000002d6adaa llvm::legacy::PassManagerImpl::run(llvm::Module&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2d6adaa)
> >    #23 0x000000000378e9a0 clang::EmitBackendOutput(clang::DiagnosticsEngine&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::TargetOptions const&, clang::LangOptions const&, llvm::DataLayout const&, clang::BackendAction, std::__1::unique_ptr<llvm::raw_pwrite_stream, std::__1::default_delete<llvm::raw_pwrite_stream> >) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x378e9a0)
> >    #24 0x0000000003ebec56 clang::BackendConsumer::HandleTranslationUnit(clang::ASTContext&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3ebec56)
> >    #25 0x0000000004dbbc84 clang::ParseAST(clang::Sema&, bool, bool) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x4dbbc84)
> >    #26 0x0000000003e0d560 clang::FrontendAction::Execute() (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3e0d560)
> >    #27 0x0000000003d596da clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3d596da)
> >    #28 0x0000000003eb890e (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3eb890e)
> >    #29 0x0000000002107abe cc1_main(llvm::ArrayRef<char char (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2107abe)
> >    #30 0x00000000021054ee ExecuteCC1Tool(llvm::SmallVectorImpl<char (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x21054ee)
> >    #31 0x0000000003c04bd2 void llvm::function_ref<void ()>::callback_fn<clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef> >, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> const::$_1>(long) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3c04bd2)
> >    #32 0x00000000034d5a2b llvm::CrashRecoveryContext::RunSafely(llvm::function_ref<void ()>) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x34d5a2b)
> >    #33 0x0000000003c043c5 clang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringRef> >, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> const (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3c043c5)
> >    #34 0x0000000003bcc196 clang::driver::Compilation::ExecuteCommand(clang::driver::Command const&, clang::driver::Command const (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3bcc196)
> >    #35 0x0000000003bcc617 clang::driver::Compilation::ExecuteJobs(clang::driver::JobList const&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command >&) const (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3bcc617)
> >    #36 0x0000000003be5a81 clang::driver::Driver::ExecuteCompilation(clang::driver::Compilation&, llvm::SmallVectorImpl<std::__1::pair<int, clang::driver::Command >&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3be5a81)
> >    #37 0x0000000002104e21 main (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2104e21)
> >    #38 0x00007f04bb011d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x26d0a)
> >    #39 0x0000000002102299 _start (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2102299)
> >    clang-12: error: clang frontend command failed with exit code 70 (use -v to see invocation)
> >    clang version 12.0.0
> >    Target: hexagon-unknown-linux-musl
> >    Thread model: posix
> >    InstalledDir: /opt/cross/clang_hexagon/x86_64-linux-gnu/bin
> >    clang-12: note: diagnostic msg:
> >    Makefile arch fs include kernel nr_bisected scripts source usr
> > 
> > 
> > vim +/folio +979 fs/netfs/read_helper.c
> > 
> >    947	
> >    948		ret = netfs_rreq_add_folios_to_buffer(rreq, want_index, have_index - 1,
> >    949						      gfp_mask);
> >    950		if (ret < 0)
> >    951			return ret;
> >    952		have_folios += have_index - want_index;
> >    953	
> >    954		ret = netfs_rreq_add_folios_to_buffer(rreq, have_index + have_folios,
> >    955						      want_index + want_folios - 1,
> >    956						      gfp_mask);
> >    957		if (ret < 0)
> >    958			return ret;
> >    959	
> >    960		/* Transfer the folios proposed by the VM into the buffer and take refs
> >    961		 * on them.  The locks will be dropped in netfs_rreq_unlock().
> >    962		 */
> >    963		if (ractl) {
> >    964			while ((folio = readahead_folio(ractl))) {
> >    965				folio_get(folio);
> >    966				if (folio == keep)
> >    967					folio_get(folio);
> >    968				ret = xa_insert_set_mark(&rreq->buffer,
> >    969							 folio_index(folio), folio,
> >    970							 XA_MARK_0, gfp_mask);
> >    971				if (ret < 0) {
> >    972					if (folio != keep)
> >    973						folio_unlock(folio);
> >    974					folio_put(folio);
> >    975					return ret;
> >    976				}
> >    977			}
> >    978		} else {
> >  > 979			folio_get(folio);
> >    980			ret = xa_insert_set_mark(&rreq->buffer, keep->index, keep,
> >    981						 XA_MARK_0, gfp_mask);
> >    982			if (ret < 0) {
> >    983				folio_put(folio);
> >    984				return ret;
> >    985			}
> >    986		}
> >    987		return 0;
> >    988	}
> >    989	
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
