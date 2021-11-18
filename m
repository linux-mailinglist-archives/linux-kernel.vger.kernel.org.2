Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EC2455D88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhKROMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:12:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:59167 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232597AbhKROL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:11:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="234021610"
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="gz'50?scan'50,208,50";a="234021610"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 06:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="gz'50?scan'50,208,50";a="495393829"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Nov 2021 06:08:57 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mni5w-0003B7-IO; Thu, 18 Nov 2021 14:08:56 +0000
Date:   Thu, 18 Nov 2021 22:08:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/batch 13/29] kernel/bpf/core.c:2287:3: error:
 implicit declaration of function 'bpf_tramp_detach'
Message-ID: <202111182238.aVZr0g8U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/batch
head:   5f1f613266bf58f8424a93e1f8b99c4ac8fa6c2b
commit: c04eb2ad90ed0981f4dc7d04249a9c84726f9ef0 [13/29] bpf: Add bpf_tramp_attach layer for trampoline attachment
config: um-i386_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=c04eb2ad90ed0981f4dc7d04249a9c84726f9ef0
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/batch
        git checkout c04eb2ad90ed0981f4dc7d04249a9c84726f9ef0
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=i386

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/core.c:1368:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1368 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:1811:6: warning: no previous prototype for 'bpf_patch_call_args' [-Wmissing-prototypes]
    1811 | void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c: In function 'bpf_prog_free_deferred':
>> kernel/bpf/core.c:2287:3: error: implicit declaration of function 'bpf_tramp_detach' [-Werror=implicit-function-declaration]
    2287 |   bpf_tramp_detach(aux->dst_attach);
         |   ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/bpf_tramp_detach +2287 kernel/bpf/core.c

  2268	
  2269	static void bpf_prog_free_deferred(struct work_struct *work)
  2270	{
  2271		struct bpf_prog_aux *aux;
  2272		int i;
  2273	
  2274		aux = container_of(work, struct bpf_prog_aux, work);
  2275	#ifdef CONFIG_BPF_SYSCALL
  2276		bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
  2277	#endif
  2278		bpf_free_used_maps(aux);
  2279		bpf_free_used_btfs(aux);
  2280		if (bpf_prog_is_dev_bound(aux))
  2281			bpf_prog_offload_destroy(aux->prog);
  2282	#ifdef CONFIG_PERF_EVENTS
  2283		if (aux->prog->has_callchain_buf)
  2284			put_callchain_buffers();
  2285	#endif
  2286		if (aux->dst_attach)
> 2287			bpf_tramp_detach(aux->dst_attach);
  2288		for (i = 0; i < aux->func_cnt; i++) {
  2289			/* We can just unlink the subprog poke descriptor table as
  2290			 * it was originally linked to the main program and is also
  2291			 * released along with it.
  2292			 */
  2293			aux->func[i]->aux->poke_tab = NULL;
  2294			bpf_jit_free(aux->func[i]);
  2295		}
  2296		if (aux->func_cnt) {
  2297			kfree(aux->func);
  2298			bpf_prog_unlock_free(aux->prog);
  2299		} else {
  2300			bpf_jit_free(aux->prog);
  2301		}
  2302	}
  2303	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AEGJJdYSq+Rnbq48JANCR3yGR46yrd0S6UpJv9l41Ih/2x639wBGonj3x/5+57lUY2Gluhzt
0RhPgTNApHC/mCdC51kHTXYzaLGjljXc9XTQBv8rIexTVfObrw//dfEf8J/3b3yGivZ8Pr3x
Vki0otAM4Kv45nvLSPwsMT3Xx9547phlU8Dqy5WQXivYbHf+83D8fSxWXAaEeF4YWTWUws4h
EvERSUOxAAqpdpNIojVmYpBhayhLwUNwrGWJqUCroaacGUuNnHNGxZveQnXumxdKQt2oS6kt
BhAphfOdYTCFAecfY2hl5KSnnRVl1DBOIeQprEuI3N8PtGH87Npp2JqWK7YQiBWp2D1PB6ON
8gldlvgWVr8SunQYQiL6r1H6KP5o0PD2eP9tf97dowV++7B7BmFCTDEGw1wzMx/osIFj8G1X
hWelvp0mbGbGwNaJ+epyIm2pptPSo1SZZ5OWqYrrzP3Qbq8Y7AbTITnTYMCbtP9gCHeQgmOE
8wqphDDB9sLuYZcRY+cCakoFEUK5ncSqJhvb2GQVF+CqHILAUFz3fHbiMrtgzFcQC3lbV+g8
5KxWuKsRgXHbk0Id2lVCRnM+kKJ7xXHJ4gFB5HMBcR1LAE4AOjKU9JbgViqX01F7bZVmcbV8
+2V72j1Ev1chK/j8r/vHKuPchWOvsPWmxve3PClmMuul4f+hAjdDYWSGWQt/Zy6qNylmWi4G
x9QLOFwTZoM45l9ZTJx3zVNkSA92rsg0pu0UP0THcYzm7cvW8AlhwCkpvayJqCYak/a1jg47
t/TZnaSN1pBxffeP2O4AAbzGiAH+CjOqBsL4LkNayhRNCWUeoSPg8QkmCABXvfn19GX/9Ov3
wwNo05dd66gnaF17Lxd1YnFiZhBl/yD3aMVMS/t6hvJOhTIYDYeda2XtOD/hsa0mNkirs8lS
JcyKjIdX0zJywBg/5sq1VEEuIwC85IzWNGSoXotLWJDe5GiLRp4m3x7Pe7yMkQXE38sugCm3
0jpljpeYkCWvlomV6Vi95OFU9ppb0zCc8Sdvvc6bVu+ZqnsY8RxdegsyqdLesWBx/y3cIy42
E9+DNM2T6a1DdM2U09uyETTxntG8k/aW0g5ZidbkMnOWA5C+9GOAmg6xS1zTX6ORfVeg1iLU
2Sf2e3e4x0lS/LW7fzlvvzzuXOVG5PKTZ0+mE5lNU4tur5eO7qMJ/FXGRZq3L+/oJuvXMs9o
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
dcpG/D8j/TKnL5oAAA==

--ibTvN161/egqYuK8--
