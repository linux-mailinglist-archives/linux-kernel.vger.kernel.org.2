Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1B440971A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344885AbhIMPVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:21:18 -0400
Received: from www62.your-server.de ([213.133.104.62]:37514 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbhIMPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:20:54 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mPnjy-000AVW-Vp; Mon, 13 Sep 2021 17:19:27 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mPnjy-000WoA-OE; Mon, 13 Sep 2021 17:19:26 +0200
Subject: Re: [dborkman:pr/bpf-cgrp 2/4] include/linux/cgroup-defs.h:771:70:
 warning: unused parameter 'skcd'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, philip.li@intel.com,
        alexei.starovoitov@gmail.com, andrii@kernel.org
References: <202109110835.fBYQcLIG-lkp@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <89bba45c-d15c-88b7-0e32-9280cd4e4990@iogearbox.net>
Date:   Mon, 13 Sep 2021 17:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <202109110835.fBYQcLIG-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26293/Mon Sep 13 10:23:39 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Philip ]

On 9/11/21 2:38 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git pr/bpf-cgrp
> head:   5a6e78baee7515884b93a90c5d03db601bc9063a
> commit: f36377d0c40cce0cdeaff50031c268bc640d94f0 [2/4] bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode
> config: i386-randconfig-r032-20210910 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git/commit/?id=f36377d0c40cce0cdeaff50031c268bc640d94f0
>          git remote add dborkman https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git
>          git fetch --no-tags dborkman pr/bpf-cgrp
>          git checkout f36377d0c40cce0cdeaff50031c268bc640d94f0
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):

Not sure how useful these warnings below are given it is quite conventional in the kernel
to have some static inline helper which e.g. look:

static inline int bla(struct foo *bar)
{
#ifdef CONFIG_<XYZ>
         return ... /// do something with bar
#else
         return 0;
#endif
}

I presume consensus here is to ignore these given also the gazillion other cases in the
kernel tree. In other words, goal on -Wunused-parameter for kernel would be to really
only catch cases where a parameter is indeed in all cases unused and should be removed
from the signature.

Thanks,
Daniel

>     In file included from include/linux/cgroup.h:28:
>     In file included from include/linux/cgroup-defs.h:22:
>     In file included from include/linux/bpf-cgroup.h:5:
>     include/linux/bpf.h:770:61: warning: unused parameter 'prog' [-Wunused-parameter]
>     static inline int bpf_trampoline_link_prog(struct bpf_prog *prog,
>                                                                 ^
>     include/linux/bpf.h:771:32: warning: unused parameter 'tr' [-Wunused-parameter]
>                                                struct bpf_trampoline *tr)
>                                                                       ^
>     include/linux/bpf.h:775:63: warning: unused parameter 'prog' [-Wunused-parameter]
>     static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog,
>                                                                   ^
>     include/linux/bpf.h:776:34: warning: unused parameter 'tr' [-Wunused-parameter]
>                                                  struct bpf_trampoline *tr)
>                                                                         ^
>     include/linux/bpf.h:780:61: warning: unused parameter 'key' [-Wunused-parameter]
>     static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
>                                                                 ^
>     include/linux/bpf.h:781:39: warning: unused parameter 'tgt_info' [-Wunused-parameter]
>                                                             struct bpf_attach_target_info *tgt_info)
>                                                                                            ^
>     include/linux/bpf.h:785:62: warning: unused parameter 'tr' [-Wunused-parameter]
>     static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
>                                                                  ^
>     include/linux/bpf.h:790:70: warning: unused parameter 'd' [-Wunused-parameter]
>     static inline void bpf_dispatcher_change_prog(struct bpf_dispatcher *d,
>                                                                          ^
>     include/linux/bpf.h:791:29: warning: unused parameter 'from' [-Wunused-parameter]
>                                                   struct bpf_prog *from,
>                                                                    ^
>     include/linux/bpf.h:792:29: warning: unused parameter 'to' [-Wunused-parameter]
>                                                   struct bpf_prog *to) {}
>                                                                    ^
>     include/linux/bpf.h:793:55: warning: unused parameter 'address' [-Wunused-parameter]
>     static inline bool is_bpf_image_address(unsigned long address)
>                                                           ^
>     include/linux/bpf.h:1012:68: warning: unused parameter 'type_id' [-Wunused-parameter]
>     static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
>                                                                        ^
>     include/linux/bpf.h:1016:52: warning: unused parameter 'btf' [-Wunused-parameter]
>     static inline void bpf_struct_ops_init(struct btf *btf,
>                                                        ^
>     include/linux/bpf.h:1017:37: warning: unused parameter 'log' [-Wunused-parameter]
>                                            struct bpf_verifier_log *log)
>                                                                     ^
>     include/linux/bpf.h:1020:51: warning: unused parameter 'data' [-Wunused-parameter]
>     static inline bool bpf_try_module_get(const void *data, struct module *owner)
>                                                       ^
>     include/linux/bpf.h:1024:47: warning: unused parameter 'data' [-Wunused-parameter]
>     static inline void bpf_module_put(const void *data, struct module *owner)
>                                                   ^
>     include/linux/bpf.h:1028:70: warning: unused parameter 'map' [-Wunused-parameter]
>     static inline int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
>                                                                          ^
>     include/linux/bpf.h:1029:18: warning: unused parameter 'key' [-Wunused-parameter]
>                                                          void *key,
>                                                                ^
>     include/linux/bpf.h:1030:18: warning: unused parameter 'value' [-Wunused-parameter]
>                                                          void *value)
>                                                                ^
>     include/linux/bpf.h:1407:44: warning: unused parameter 'map' [-Wunused-parameter]
>     bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
>                                                ^
>     include/linux/bpf.h:1414:39: warning: unused parameter 'map' [-Wunused-parameter]
>     bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
>                                           ^
>     include/linux/bpf.h:1420:44: warning: unused parameter 'map' [-Wunused-parameter]
>     bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
>                                                ^
>     In file included from drivers/gpu/drm/i915/i915_drv.c:39:
>     In file included from include/linux/vga_switcheroo.h:34:
>     In file included from include/linux/fb.h:6:
>     In file included from include/uapi/linux/fb.h:6:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:13:
>     In file included from include/linux/cgroup.h:28:
>     In file included from include/linux/cgroup-defs.h:23:
>     In file included from include/linux/psi_types.h:4:
>     include/linux/kthread.h:218:72: warning: unused parameter 'css' [-Wunused-parameter]
>     static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
>                                                                            ^
>     In file included from drivers/gpu/drm/i915/i915_drv.c:39:
>     In file included from include/linux/vga_switcheroo.h:34:
>     In file included from include/linux/fb.h:6:
>     In file included from include/uapi/linux/fb.h:6:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:13:
>     In file included from include/linux/cgroup.h:28:
>     include/linux/cgroup-defs.h:720:72: warning: unused parameter 'tsk' [-Wunused-parameter]
>     static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>                                                                            ^
>     include/linux/cgroup-defs.h:731:70: warning: unused parameter 'tsk' [-Wunused-parameter]
>     static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
>                                                                          ^
>>> include/linux/cgroup-defs.h:771:70: warning: unused parameter 'skcd' [-Wunused-parameter]
>     static inline u16 sock_cgroup_prioidx(const struct sock_cgroup_data *skcd)
>                                                                          ^
>     include/linux/cgroup-defs.h:780:70: warning: unused parameter 'skcd' [-Wunused-parameter]
>     static inline u32 sock_cgroup_classid(const struct sock_cgroup_data *skcd)
>                                                                          ^
>     include/linux/cgroup-defs.h:789:69: warning: unused parameter 'skcd' [-Wunused-parameter]
>     static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
>                                                                         ^
>>> include/linux/cgroup-defs.h:790:13: warning: unused parameter 'prioidx' [-Wunused-parameter]
>                                                u16 prioidx)
>                                                    ^
>     include/linux/cgroup-defs.h:797:69: warning: unused parameter 'skcd' [-Wunused-parameter]
>     static inline void sock_cgroup_set_classid(struct sock_cgroup_data *skcd,
>                                                                         ^
>>> include/linux/cgroup-defs.h:798:13: warning: unused parameter 'classid' [-Wunused-parameter]
>                                                u32 classid)
>                                                    ^
>     In file included from drivers/gpu/drm/i915/i915_drv.c:39:
>     In file included from include/linux/vga_switcheroo.h:34:
>     In file included from include/linux/fb.h:6:
>     In file included from include/uapi/linux/fb.h:6:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:22:
>     In file included from include/linux/writeback.h:12:
>     include/linux/backing-dev-defs.h:282:52: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline bool wb_tryget(struct bdi_writeback *wb)
>                                                        ^
>     include/linux/backing-dev-defs.h:287:49: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline void wb_get(struct bdi_writeback *wb)
>                                                     ^
>     include/linux/backing-dev-defs.h:291:49: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline void wb_put(struct bdi_writeback *wb)
>                                                     ^
>     include/linux/backing-dev-defs.h:295:54: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline void wb_put_many(struct bdi_writeback *wb, unsigned long nr)
>                                                          ^
>     include/linux/backing-dev-defs.h:295:72: warning: unused parameter 'nr' [-Wunused-parameter]
>     static inline void wb_put_many(struct bdi_writeback *wb, unsigned long nr)
>                                                                            ^
>     include/linux/backing-dev-defs.h:299:51: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline bool wb_dying(struct bdi_writeback *wb)
>                                                       ^
>     In file included from drivers/gpu/drm/i915/i915_drv.c:39:
>     In file included from include/linux/vga_switcheroo.h:34:
>     In file included from include/linux/fb.h:6:
>     In file included from include/uapi/linux/fb.h:6:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:22:
>     In file included from include/linux/writeback.h:13:
>     In file included from include/linux/blk_types.h:10:
>     In file included from include/linux/bvec.h:10:
>     In file included from include/linux/highmem.h:12:
>     In file included from arch/x86/include/asm/cacheflush.h:8:
>     include/asm-generic/cacheflush.h:21:53: warning: unused parameter 'mm' [-Wunused-parameter]
>     static inline void flush_cache_mm(struct mm_struct *mm)
>                                                         ^
>     include/asm-generic/cacheflush.h:27:57: warning: unused parameter 'mm' [-Wunused-parameter]
>     static inline void flush_cache_dup_mm(struct mm_struct *mm)
>                                                             ^
>     include/asm-generic/cacheflush.h:33:61: warning: unused parameter 'vma' [-Wunused-parameter]
>     static inline void flush_cache_range(struct vm_area_struct *vma,
>                                                                 ^
>     include/asm-generic/cacheflush.h:34:24: warning: unused parameter 'start' [-Wunused-parameter]
>                                          unsigned long start,
>                                                        ^
>     include/asm-generic/cacheflush.h:35:24: warning: unused parameter 'end' [-Wunused-parameter]
>                                          unsigned long end)
>                                                        ^
>     include/asm-generic/cacheflush.h:41:60: warning: unused parameter 'vma' [-Wunused-parameter]
>     static inline void flush_cache_page(struct vm_area_struct *vma,
>                                                                ^
>     include/asm-generic/cacheflush.h:42:23: warning: unused parameter 'vmaddr' [-Wunused-parameter]
>                                         unsigned long vmaddr,
>                                                       ^
>     include/asm-generic/cacheflush.h:43:23: warning: unused parameter 'pfn' [-Wunused-parameter]
>                                         unsigned long pfn)
>                                                       ^
>     include/asm-generic/cacheflush.h:49:51: warning: unused parameter 'page' [-Wunused-parameter]
>     static inline void flush_dcache_page(struct page *page)
>                                                       ^
>     include/asm-generic/cacheflush.h:57:65: warning: unused parameter 'mapping' [-Wunused-parameter]
>     static inline void flush_dcache_mmap_lock(struct address_space *mapping)
>                                                                     ^
>     include/asm-generic/cacheflush.h:63:67: warning: unused parameter 'mapping' [-Wunused-parameter]
>     static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
>                                                                       ^
>     include/asm-generic/cacheflush.h:69:53: warning: unused parameter 'start' [-Wunused-parameter]
>     static inline void flush_icache_range(unsigned long start, unsigned long end)
>                                                         ^
>     include/asm-generic/cacheflush.h:69:74: warning: unused parameter 'end' [-Wunused-parameter]
>     static inline void flush_icache_range(unsigned long start, unsigned long end)
>                                                                              ^
>     include/asm-generic/cacheflush.h:79:61: warning: unused parameter 'vma' [-Wunused-parameter]
>     static inline void flush_icache_page(struct vm_area_struct *vma,
>                                                                 ^
>     include/asm-generic/cacheflush.h:80:23: warning: unused parameter 'page' [-Wunused-parameter]
>                                          struct page *page)
>                                                       ^
>     include/asm-generic/cacheflush.h:86:66: warning: unused parameter 'vma' [-Wunused-parameter]
>     static inline void flush_icache_user_page(struct vm_area_struct *vma,
>                                                                      ^
>     include/asm-generic/cacheflush.h:87:22: warning: unused parameter 'page' [-Wunused-parameter]
>                                                struct page *page,
>                                                             ^
>     include/asm-generic/cacheflush.h:88:23: warning: unused parameter 'addr' [-Wunused-parameter]
>                                                unsigned long addr, int len)
>                                                              ^
>     include/asm-generic/cacheflush.h:88:33: warning: unused parameter 'len' [-Wunused-parameter]
>                                                unsigned long addr, int len)
> --
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:13:
>     In file included from include/linux/cgroup.h:28:
>     In file included from include/linux/cgroup-defs.h:22:
>     In file included from include/linux/bpf-cgroup.h:5:
>     include/linux/bpf.h:770:61: warning: unused parameter 'prog' [-Wunused-parameter]
>     static inline int bpf_trampoline_link_prog(struct bpf_prog *prog,
>                                                                 ^
>     include/linux/bpf.h:771:32: warning: unused parameter 'tr' [-Wunused-parameter]
>                                                struct bpf_trampoline *tr)
>                                                                       ^
>     include/linux/bpf.h:775:63: warning: unused parameter 'prog' [-Wunused-parameter]
>     static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog,
>                                                                   ^
>     include/linux/bpf.h:776:34: warning: unused parameter 'tr' [-Wunused-parameter]
>                                                  struct bpf_trampoline *tr)
>                                                                         ^
>     include/linux/bpf.h:780:61: warning: unused parameter 'key' [-Wunused-parameter]
>     static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
>                                                                 ^
>     include/linux/bpf.h:781:39: warning: unused parameter 'tgt_info' [-Wunused-parameter]
>                                                             struct bpf_attach_target_info *tgt_info)
>                                                                                            ^
>     include/linux/bpf.h:785:62: warning: unused parameter 'tr' [-Wunused-parameter]
>     static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
>                                                                  ^
>     include/linux/bpf.h:790:70: warning: unused parameter 'd' [-Wunused-parameter]
>     static inline void bpf_dispatcher_change_prog(struct bpf_dispatcher *d,
>                                                                          ^
>     include/linux/bpf.h:791:29: warning: unused parameter 'from' [-Wunused-parameter]
>                                                   struct bpf_prog *from,
>                                                                    ^
>     include/linux/bpf.h:792:29: warning: unused parameter 'to' [-Wunused-parameter]
>                                                   struct bpf_prog *to) {}
>                                                                    ^
>     include/linux/bpf.h:793:55: warning: unused parameter 'address' [-Wunused-parameter]
>     static inline bool is_bpf_image_address(unsigned long address)
>                                                           ^
>     include/linux/bpf.h:1012:68: warning: unused parameter 'type_id' [-Wunused-parameter]
>     static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
>                                                                        ^
>     include/linux/bpf.h:1016:52: warning: unused parameter 'btf' [-Wunused-parameter]
>     static inline void bpf_struct_ops_init(struct btf *btf,
>                                                        ^
>     include/linux/bpf.h:1017:37: warning: unused parameter 'log' [-Wunused-parameter]
>                                            struct bpf_verifier_log *log)
>                                                                     ^
>     include/linux/bpf.h:1020:51: warning: unused parameter 'data' [-Wunused-parameter]
>     static inline bool bpf_try_module_get(const void *data, struct module *owner)
>                                                       ^
>     include/linux/bpf.h:1024:47: warning: unused parameter 'data' [-Wunused-parameter]
>     static inline void bpf_module_put(const void *data, struct module *owner)
>                                                   ^
>     include/linux/bpf.h:1028:70: warning: unused parameter 'map' [-Wunused-parameter]
>     static inline int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
>                                                                          ^
>     include/linux/bpf.h:1029:18: warning: unused parameter 'key' [-Wunused-parameter]
>                                                          void *key,
>                                                                ^
>     include/linux/bpf.h:1030:18: warning: unused parameter 'value' [-Wunused-parameter]
>                                                          void *value)
>                                                                ^
>     include/linux/bpf.h:1407:44: warning: unused parameter 'map' [-Wunused-parameter]
>     bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
>                                                ^
>     include/linux/bpf.h:1414:39: warning: unused parameter 'map' [-Wunused-parameter]
>     bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
>                                           ^
>     include/linux/bpf.h:1420:44: warning: unused parameter 'map' [-Wunused-parameter]
>     bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
>                                                ^
>     In file included from drivers/gpu/drm/i915/i915_config.c:6:
>     In file included from drivers/gpu/drm/i915/i915_drv.h:39:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:13:
>     In file included from include/linux/cgroup.h:28:
>     In file included from include/linux/cgroup-defs.h:23:
>     In file included from include/linux/psi_types.h:4:
>     include/linux/kthread.h:218:72: warning: unused parameter 'css' [-Wunused-parameter]
>     static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
>                                                                            ^
>     In file included from drivers/gpu/drm/i915/i915_config.c:6:
>     In file included from drivers/gpu/drm/i915/i915_drv.h:39:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:13:
>     In file included from include/linux/cgroup.h:28:
>     include/linux/cgroup-defs.h:720:72: warning: unused parameter 'tsk' [-Wunused-parameter]
>     static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>                                                                            ^
>     include/linux/cgroup-defs.h:731:70: warning: unused parameter 'tsk' [-Wunused-parameter]
>     static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
>                                                                          ^
>>> include/linux/cgroup-defs.h:771:70: warning: unused parameter 'skcd' [-Wunused-parameter]
>     static inline u16 sock_cgroup_prioidx(const struct sock_cgroup_data *skcd)
>                                                                          ^
>     include/linux/cgroup-defs.h:780:70: warning: unused parameter 'skcd' [-Wunused-parameter]
>     static inline u32 sock_cgroup_classid(const struct sock_cgroup_data *skcd)
>                                                                          ^
>     include/linux/cgroup-defs.h:789:69: warning: unused parameter 'skcd' [-Wunused-parameter]
>     static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
>                                                                         ^
>>> include/linux/cgroup-defs.h:790:13: warning: unused parameter 'prioidx' [-Wunused-parameter]
>                                                u16 prioidx)
>                                                    ^
>     include/linux/cgroup-defs.h:797:69: warning: unused parameter 'skcd' [-Wunused-parameter]
>     static inline void sock_cgroup_set_classid(struct sock_cgroup_data *skcd,
>                                                                         ^
>>> include/linux/cgroup-defs.h:798:13: warning: unused parameter 'classid' [-Wunused-parameter]
>                                                u32 classid)
>                                                    ^
>     In file included from drivers/gpu/drm/i915/i915_config.c:6:
>     In file included from drivers/gpu/drm/i915/i915_drv.h:39:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:22:
>     In file included from include/linux/writeback.h:12:
>     include/linux/backing-dev-defs.h:282:52: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline bool wb_tryget(struct bdi_writeback *wb)
>                                                        ^
>     include/linux/backing-dev-defs.h:287:49: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline void wb_get(struct bdi_writeback *wb)
>                                                     ^
>     include/linux/backing-dev-defs.h:291:49: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline void wb_put(struct bdi_writeback *wb)
>                                                     ^
>     include/linux/backing-dev-defs.h:295:54: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline void wb_put_many(struct bdi_writeback *wb, unsigned long nr)
>                                                          ^
>     include/linux/backing-dev-defs.h:295:72: warning: unused parameter 'nr' [-Wunused-parameter]
>     static inline void wb_put_many(struct bdi_writeback *wb, unsigned long nr)
>                                                                            ^
>     include/linux/backing-dev-defs.h:299:51: warning: unused parameter 'wb' [-Wunused-parameter]
>     static inline bool wb_dying(struct bdi_writeback *wb)
>                                                       ^
>     In file included from drivers/gpu/drm/i915/i915_config.c:6:
>     In file included from drivers/gpu/drm/i915/i915_drv.h:39:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:22:
>     In file included from include/linux/writeback.h:14:
>     In file included from include/linux/blk-cgroup.h:23:
>     In file included from include/linux/blkdev.h:8:
>     include/linux/genhd.h:302:60: warning: unused parameter 'bdev' [-Wunused-parameter]
>     static inline int bd_link_disk_holder(struct block_device *bdev,
>                                                                ^
>     include/linux/genhd.h:303:27: warning: unused parameter 'disk' [-Wunused-parameter]
>                                           struct gendisk *disk)
>                                                           ^
>     include/linux/genhd.h:307:63: warning: unused parameter 'bdev' [-Wunused-parameter]
>     static inline void bd_unlink_disk_holder(struct block_device *bdev,
>                                                                   ^
>     include/linux/genhd.h:308:23: warning: unused parameter 'disk' [-Wunused-parameter]
>                                              struct gendisk *disk)
>                                                              ^
>     include/linux/genhd.h:311:63: warning: unused parameter 'disk' [-Wunused-parameter]
>     static inline int bd_register_pending_holders(struct gendisk *disk)
>                                                                   ^
>     In file included from drivers/gpu/drm/i915/i915_config.c:6:
>     In file included from drivers/gpu/drm/i915/i915_drv.h:39:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:22:
>     In file included from include/linux/writeback.h:14:
>     In file included from include/linux/blk-cgroup.h:23:
>     In file included from include/linux/blkdev.h:17:
>     include/linux/bio.h:394:14: warning: comparison of integers of different signs: 'int' and 'unsigned int' [-Wsign-compare]
>             if (sectors >= bio_sectors(bio))
>                 ~~~~~~~ ^  ~~~~~~~~~~~~~~~~
>     include/linux/bio.h:516:51: warning: unused parameter 'bio' [-Wunused-parameter]
>     static inline void bio_associate_blkg(struct bio *bio) { }
>                                                       ^
>     include/linux/bio.h:517:60: warning: unused parameter 'bio' [-Wunused-parameter]
>     static inline void bio_associate_blkg_from_css(struct bio *bio,
>                                                                ^
>     include/linux/bio.h:518:41: warning: unused parameter 'css' [-Wunused-parameter]
>                                                    struct cgroup_subsys_state *css)
>                                                                                ^
>     include/linux/bio.h:520:59: warning: unused parameter 'dst' [-Wunused-parameter]
>     static inline void bio_clone_blkg_association(struct bio *dst,
>                                                               ^
>     include/linux/bio.h:521:24: warning: unused parameter 'src' [-Wunused-parameter]
>                                                   struct bio *src) { }
>                                                               ^
>     In file included from drivers/gpu/drm/i915/i915_config.c:6:
>     In file included from drivers/gpu/drm/i915/i915_drv.h:39:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:22:
>     In file included from include/linux/writeback.h:14:
>     In file included from include/linux/blk-cgroup.h:23:
>     include/linux/blkdev.h:866:58: warning: unused parameter 'rq' [-Wunused-parameter]
>     static inline void rq_flush_dcache_pages(struct request *rq)
>                                                              ^
>     In file included from drivers/gpu/drm/i915/i915_config.c:6:
>     In file included from drivers/gpu/drm/i915/i915_drv.h:39:
>     In file included from include/linux/i2c.h:18:
>     In file included from include/linux/regulator/consumer.h:35:
>     In file included from include/linux/suspend.h:5:
>     In file included from include/linux/swap.h:9:
>     In file included from include/linux/memcontrol.h:22:
> ..
