Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E703F2141
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhHST7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhHST7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:59:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B6CA60462;
        Thu, 19 Aug 2021 19:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629403149;
        bh=wZLWzge5RhCuX8MBK9EyEqHoqZl82FgCkrvSRpzrct0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+c3ox6C9SXNpsR8XVAKAO7/w/BYOucl4Ak9+BLWqNgW+MnZIuM/RJmQNQwoV5GMF
         mHyzUgho1gSsK+MC1gFD1BVKTSGVTC0lsJxrQjEpr0IKS6kCh6eO3K6J4if62SwTIf
         6GoHySCWGKrGQCOAW967Gs6G2COUicG4PhDzEe7mnVO0Nmkam9bj8vgBq8UP0Ej4Gx
         RwFAQulTz0PAVqmM8HRIauPS0rLYbga6ZwnoGMFGAXIW3zb7TuEm1KZ/p8bJzPCXcq
         CSqojDtguoBmMiwXoNwXNVDRNvoPvHMWoNCSctuj911ecE0jwPlSzmSXoDIvWNCqrP
         AzsvS8oy/XvQQ==
Date:   Thu, 19 Aug 2021 12:59:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>, Philip Li <philip.li@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [dhowells-fs:netfs-folio-regions 11/28]
 fs/netfs/read_helper.c:979:13: warning: variable 'folio' is uninitialized
 when used here
Message-ID: <YR64CsQVrynR4V/y@Ryzen-9-3900X.localdomain>
References: <202108200354.7eThNmGj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202108200354.7eThNmGj-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 03:07:06AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
=2Egit netfs-folio-regions
> head:   215a4ee495a95cc73256ed76f91cb78bcabd6b8e
> commit: 90417b52931da8cb4eb670c3cc22bfa12aabe55c [11/28] netfs: Use a buf=
fer in netfs_read_request and add pages to it
> config: hexagon-randconfig-r041-20210818 (attached as .config)
> compiler: clang version 12.0.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-=
fs.git/commit/?id=3D90417b52931da8cb4eb670c3cc22bfa12aabe55c
>         git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/k=
ernel/git/dhowells/linux-fs.git
>         git fetch --no-tags dhowells-fs netfs-folio-regions
>         git checkout 90417b52931da8cb4eb670c3cc22bfa12aabe55c
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross O=
=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash fs/netfs/
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> fs/netfs/read_helper.c:979:13: warning: variable 'folio' is uninitiali=
zed when used here
>    folio_get(folio);
>    ^~~~~
>    fs/netfs/read_helper.c:932:21: note: initialize the variable 'folio' t=
o silence this warning
>    struct folio
>    ^
>    =3D NULL
>    fatal error: error in backend: Misaligned constant address: 0x0000001b=
 has alignment 1, but the memory access requires 4

This crash has been fixed in clang-13 [1]. Philip, would it be possible for
the robot to use the same clang version for Hexagon that you use for all of=
 the
other architectures? It should have no issues, as we are using it in our
CI. If there are, please let me know so I can try to get them triaged
and fixed upstream,

[1] https://bugs.llvm.org/show_bug.cgi?id=3D50838

Cheers,
Nathan

>    PLEASE submit a bug report to https://bugs.llvm.org/ and include the c=
rash backtrace, preprocessed source, and associated run script.
>    Stack dump:
>    0. Program arguments: clang -Wp,-MMD,fs/netfs/.read_helper.o.d -nostdi=
nc -isystem /opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x=
86_64-linux-gnu/lib/clang/12.0.0/include -Iarch/hexagon/include -I./arch/he=
xagon/include/generated -Iinclude -I./include -Iarch/hexagon/include/uapi -=
I./arch/hexagon/include/generated/uapi -Iinclude/uapi -I./include/generated=
/uapi -include include/linux/compiler-version.h -include include/linux/kcon=
fig.h -include include/linux/compiler_types.h -D__KERNEL__ -Qunused-argumen=
ts -fmacro-prefix-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wundef -Werror=3Dst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wch=
ar -fno-PIE -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int =
-Werror=3Dreturn-type -Wno-format-security -std=3Dgnu89 --target=3Dhexagon-=
unknown-linux-musl -integrated-as -Werror=3Dunknown-warning-option -G0 -fno=
-short-enums -mlong-calls -ffixed-r19 -DTHREADINFO_REG=3Dr19 -D__linux__ -f=
no-delete-null-pointer-checks -Wno-frame-address -Wno-address-of-packed-mem=
ber -O2 -Wframe-larger-than=3D1024 -fno-stack-protector -Wno-format-invalid=
-specifier -Wno-gnu -mno-global-merge -Wno-unused-const-variable -fno-omit-=
frame-pointer -fno-optimize-sibling-calls -ftrivial-auto-var-init=3Dpattern=
 -fno-stack-clash-protection -falign-functions=3D64 -Wdeclaration-after-sta=
tement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-strict-overflow -fno-=
stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Wextr=
a -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-at=
tribute -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs =
-Wunused-const-variable -Wno-missing-field-initializers -Wno-sign-compare -=
Wno-type-limits -I fs/netfs -I ./fs/netfs -DKBUILD_MODFILE=3D"fs/netfs/netf=
s" -DKBUILD_BASENAME=3D"read_helper" -DKBUILD_MODNAME=3D"netfs" -D__KBUILD_=
MODNAME=3Dkmod_netfs -c -o fs/netfs/read_helper.o fs/netfs/read_helper.c
>    1. <eof> parser at end of file
>    2. Code generation
>    3. Running pass 'Function Pass Manager' on module 'fs/netfs/read_helpe=
r.c'.
>    4. Running pass 'Hexagon DAG->DAG Pattern Instruction Selection' on fu=
nction '@netfs_rreq_set_up_buffer'
>    #0 0x000000000355d1fc llvm::sys::PrintStackTrace(llvm::raw_ostream&, i=
nt) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-l=
inux-gnu/bin/clang-12+0x355d1fc)
>    #1 0x000000000355afbe llvm::sys::RunSignalHandlers() (/opt/cross/clang=
+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12=
+0x355afbe)
>    #2 0x000000000355c55d llvm::sys::CleanupOnSignal(unsigned long) (/opt/=
cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/b=
in/clang-12+0x355c55d)
>    #3 0x00000000034d5aed (anonymous namespace)::CrashRecoveryContextImpl:=
:HandleCrash(int, unsigned long) (/opt/cross/clang+llvm-12.0.0-cross-hexago=
n-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x34d5aed)
>    #4 0x00000000034d5a79 llvm::CrashRecoveryContext::HandleExit(int) (/op=
t/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu=
/bin/clang-12+0x34d5a79)
>    #5 0x0000000003557e07 llvm::sys::Process::Exit(int, bool) (/opt/cross/=
clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/cla=
ng-12+0x3557e07)
>    #6 0x0000000002107e10 llvm::DenseMapBase<llvm::DenseMap<llvm::AliasSet=
Tracker::ASTCallbackVH, llvm::AliasSetTracker::ASTCallbackVHDenseMapInfo, l=
lvm::detail::DenseMapPair<llvm::AliasSetTracker::ASTCallbackVH, >, llvm::Al=
iasSetTracker::ASTCallbackVH, llvm::AliasSetTracker::ASTCallbackVHDenseMapI=
nfo, llvm::detail::DenseMapPair<llvm::AliasSetTracker::ASTCallbackVH, >::de=
stroyAll() (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x=
86_64-linux-gnu/bin/clang-12+0x2107e10)
>    #7 0x00000000034da319 llvm::report_fatal_error(llvm::Twine const&, boo=
l) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-li=
nux-gnu/bin/clang-12+0x34da319)
>    #8 0x00000000034da3e7 (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unkn=
own-linux-musl/x86_64-linux-gnu/bin/clang-12+0x34da3e7)
>    #9 0x0000000002411b46 (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unkn=
own-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2411b46)
>    #10 0x00000000024183c0 llvm::HexagonTargetLowering::LowerLoad(llvm::SD=
Value, llvm::SelectionDAG&) const (/opt/cross/clang+llvm-12.0.0-cross-hexag=
on-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x24183c0)
>    #11 0x0000000002419cbb llvm::HexagonTargetLowering::LowerOperation(llv=
m::SDValue, llvm::SelectionDAG&) const (/opt/cross/clang+llvm-12.0.0-cross-=
hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2419cbb)
>    #12 0x00000000042c3b6a (anonymous (/opt/cross/clang+llvm-12.0.0-cross-=
hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x42c3b6a)
>    #13 0x00000000042a61af (anonymous (/opt/cross/clang+llvm-12.0.0-cross-=
hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x42a61af)
>    #14 0x00000000042a5443 llvm::SelectionDAG::Legalize() (/opt/cross/clan=
g+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-1=
2+0x42a5443)
>    #15 0x0000000004375361 llvm::SelectionDAGISel::CodeGenAndEmitDAG() (/o=
pt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gn=
u/bin/clang-12+0x4375361)
>    #16 0x0000000004373545 llvm::SelectionDAGISel::SelectAllBasicBlocks(ll=
vm::Function const&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-li=
nux-musl/x86_64-linux-gnu/bin/clang-12+0x4373545)
>    #17 0x00000000043703b7 llvm::SelectionDAGISel::runOnMachineFunction(ll=
vm::MachineFunction&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-l=
inux-musl/x86_64-linux-gnu/bin/clang-12+0x43703b7)
>    #18 0x00000000024690c4 llvm::HexagonDAGToDAGISel::runOnMachineFunction=
(llvm::MachineFunction&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknow=
n-linux-musl/x86_64-linux-gnu/bin/clang-12+0x24690c4)
>    #19 0x000000000290c1bd llvm::MachineFunctionPass::runOnFunction(llvm::=
Function&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x=
86_64-linux-gnu/bin/clang-12+0x290c1bd)
>    #20 0x0000000002d6a745 llvm::FPPassManager::runOnFunction(llvm::Functi=
on&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-=
linux-gnu/bin/clang-12+0x2d6a745)
>    #21 0x0000000002d70c51 llvm::FPPassManager::runOnModule(llvm::Module&)=
 (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linu=
x-gnu/bin/clang-12+0x2d70c51)
>    #22 0x0000000002d6adaa llvm::legacy::PassManagerImpl::run(llvm::Module=
&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-li=
nux-gnu/bin/clang-12+0x2d6adaa)
>    #23 0x000000000378e9a0 clang::EmitBackendOutput(clang::DiagnosticsEngi=
ne&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang=
::TargetOptions const&, clang::LangOptions const&, llvm::DataLayout const&,=
 clang::BackendAction, std::__1::unique_ptr<llvm::raw_pwrite_stream, std::_=
_1::default_delete<llvm::raw_pwrite_stream> >) (/opt/cross/clang+llvm-12.0.=
0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x378e9a0)
>    #24 0x0000000003ebec56 clang::BackendConsumer::HandleTranslationUnit(c=
lang::ASTContext&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linu=
x-musl/x86_64-linux-gnu/bin/clang-12+0x3ebec56)
>    #25 0x0000000004dbbc84 clang::ParseAST(clang::Sema&, bool, bool) (/opt=
/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/=
bin/clang-12+0x4dbbc84)
>    #26 0x0000000003e0d560 clang::FrontendAction::Execute() (/opt/cross/cl=
ang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang=
-12+0x3e0d560)
>    #27 0x0000000003d596da clang::CompilerInstance::ExecuteAction(clang::F=
rontendAction&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-m=
usl/x86_64-linux-gnu/bin/clang-12+0x3d596da)
>    #28 0x0000000003eb890e (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unk=
nown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3eb890e)
>    #29 0x0000000002107abe cc1_main(llvm::ArrayRef<char char (/opt/cross/c=
lang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clan=
g-12+0x2107abe)
>    #30 0x00000000021054ee ExecuteCC1Tool(llvm::SmallVectorImpl<char (/opt=
/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/=
bin/clang-12+0x21054ee)
>    #31 0x0000000003c04bd2 void llvm::function_ref<void ()>::callback_fn<c=
lang::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::Strin=
gRef> >, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1=
::allocator<char> const::$_1>(long) (/opt/cross/clang+llvm-12.0.0-cross-hex=
agon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3c04bd2)
>    #32 0x00000000034d5a2b llvm::CrashRecoveryContext::RunSafely(llvm::fun=
ction_ref<void ()>) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-lin=
ux-musl/x86_64-linux-gnu/bin/clang-12+0x34d5a2b)
>    #33 0x0000000003c043c5 clang::driver::CC1Command::Execute(llvm::ArrayR=
ef<llvm::Optional<llvm::StringRef> >, std::__1::basic_string<char, std::__1=
::char_traits<char>, std::__1::allocator<char> const (/opt/cross/clang+llvm=
-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3c=
043c5)
>    #34 0x0000000003bcc196 clang::driver::Compilation::ExecuteCommand(clan=
g::driver::Command const&, clang::driver::Command const (/opt/cross/clang+l=
lvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0=
x3bcc196)
>    #35 0x0000000003bcc617 clang::driver::Compilation::ExecuteJobs(clang::=
driver::JobList const&, llvm::SmallVectorImpl<std::__1::pair<int, clang::dr=
iver::Command >&) const (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown=
-linux-musl/x86_64-linux-gnu/bin/clang-12+0x3bcc617)
>    #36 0x0000000003be5a81 clang::driver::Driver::ExecuteCompilation(clang=
::driver::Compilation&, llvm::SmallVectorImpl<std::__1::pair<int, clang::dr=
iver::Command >&) (/opt/cross/clang+llvm-12.0.0-cross-hexagon-unknown-linux=
-musl/x86_64-linux-gnu/bin/clang-12+0x3be5a81)
>    #37 0x0000000002104e21 main (/opt/cross/clang+llvm-12.0.0-cross-hexago=
n-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2104e21)
>    #38 0x00007f04bb011d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.s=
o.6+0x26d0a)
>    #39 0x0000000002102299 _start (/opt/cross/clang+llvm-12.0.0-cross-hexa=
gon-unknown-linux-musl/x86_64-linux-gnu/bin/clang-12+0x2102299)
>    clang-12: error: clang frontend command failed with exit code 70 (use =
-v to see invocation)
>    clang version 12.0.0
>    Target: hexagon-unknown-linux-musl
>    Thread model: posix
>    InstalledDir: /opt/cross/clang_hexagon/x86_64-linux-gnu/bin
>    clang-12: note: diagnostic msg:
>    Makefile arch fs include kernel nr_bisected scripts source usr
>=20
>=20
> vim +/folio +979 fs/netfs/read_helper.c
>=20
>    947=09
>    948		ret =3D netfs_rreq_add_folios_to_buffer(rreq, want_index, have_in=
dex - 1,
>    949						      gfp_mask);
>    950		if (ret < 0)
>    951			return ret;
>    952		have_folios +=3D have_index - want_index;
>    953=09
>    954		ret =3D netfs_rreq_add_folios_to_buffer(rreq, have_index + have_f=
olios,
>    955						      want_index + want_folios - 1,
>    956						      gfp_mask);
>    957		if (ret < 0)
>    958			return ret;
>    959=09
>    960		/* Transfer the folios proposed by the VM into the buffer and tak=
e refs
>    961		 * on them.  The locks will be dropped in netfs_rreq_unlock().
>    962		 */
>    963		if (ractl) {
>    964			while ((folio =3D readahead_folio(ractl))) {
>    965				folio_get(folio);
>    966				if (folio =3D=3D keep)
>    967					folio_get(folio);
>    968				ret =3D xa_insert_set_mark(&rreq->buffer,
>    969							 folio_index(folio), folio,
>    970							 XA_MARK_0, gfp_mask);
>    971				if (ret < 0) {
>    972					if (folio !=3D keep)
>    973						folio_unlock(folio);
>    974					folio_put(folio);
>    975					return ret;
>    976				}
>    977			}
>    978		} else {
>  > 979			folio_get(folio);
>    980			ret =3D xa_insert_set_mark(&rreq->buffer, keep->index, keep,
>    981						 XA_MARK_0, gfp_mask);
>    982			if (ret < 0) {
>    983				folio_put(folio);
>    984				return ret;
>    985			}
>    986		}
>    987		return 0;
>    988	}
>    989=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


