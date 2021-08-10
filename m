Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345133D9E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhG2HK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbhG2HK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:10:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA38C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:10:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h11so6198952ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kffDx6fgCSuvfve5zp9qiGazZMkAtU/n7tZ3UyO0dtA=;
        b=qnwz0qWXOPHbGlJZIThnD2zbgwQr8xlffqX6/DLjZZa8+SsnibUM38ZN9F8fAWk+JO
         a+5hIKLyLtmcfR15WI9kkrBT3Ntwg2MMDfk/KUPHPzdg//evi530qEo9btDyPyVRkNSp
         kBUbUFS6XBHQEI8gxSF7f66ArY7jQyUBElRfaQJQxlgIV8xH/QHLNrC9RuveTbuKQdlu
         2WSOPPwtTX5XDvgQKfSwn0sHiAEabjTk82k4bXpRhDHzgZeHBqjbD74f5YGOlVbAIguN
         d9StuLkKBI5N8rK9Ha/yCRaeJZksFD+vwssgNlfQlFq3W/vJr5CM+6SlVMhiZZxki6Sa
         ASxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kffDx6fgCSuvfve5zp9qiGazZMkAtU/n7tZ3UyO0dtA=;
        b=eZvw1pmv95klcgycMEiCuqYz5nu2zIApz0kar7+9xAcuPUxhJvmx4s53Frmsyp4CwI
         OkFoaxsqdw4Bp+djkd787sUvt2NidpEr3fmIbGIm6LPsOvdmlMIP6UjGGb9IE8g+g1Fi
         51eEZiygawvewh3E7YRxojVqMWyedaD5KLYWRw4UTRT//nu/Uj/sTbGfWOzNHsEyeos1
         LpyUP6RNCsIcQPYo879ADU5/bjziULpWYz8AfG6FM0c8YSvI3Ba0BEUYF/C7Q0iYOVZ0
         TccUD3QrfO6ykrr2zB4hXupOUuvttKT/lF1uJS0UAW839jiinRPOpP90VJ8vDodX/VfI
         BrJA==
X-Gm-Message-State: AOAM532uyX1GQ5bFwnRQIHO9/SWvOta9d/MvDtRVwOndHDbinsnVICFg
        4kp3kQtqTXurfO2wvliiBGrFzw==
X-Google-Smtp-Source: ABdhPJxXy0RdVUQfe5ervms4TVbUJovVSBhdgVxh2HtIsArHS6C3EmYL9DyLhovwdblOOfgDQi7gnw==
X-Received: by 2002:a2e:a288:: with SMTP id k8mr1934593lja.107.1627542651540;
        Thu, 29 Jul 2021 00:10:51 -0700 (PDT)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id m25sm217478lfq.209.2021.07.29.00.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:10:51 -0700 (PDT)
Date:   Thu, 29 Jul 2021 09:10:49 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3 4/5] optee: isolate smc abi
Message-ID: <20210729071049.GC3316601@jade>
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
 <20210722121757.1944658-5-jens.wiklander@linaro.org>
 <CAFA6WYPmHF-SLGV50phb2qY92+L2qo3zcAsBjGGFCSwyPP_g4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYPmHF-SLGV50phb2qY92+L2qo3zcAsBjGGFCSwyPP_g4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 03:40:05PM +0530, Sumit Garg wrote:
> On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Isolate the ABI based on raw SMCs. Code specific to the raw SMC ABI is
> > moved into smc_abi.c. This makes room for other ABIs with a clear
> > separation.
> >
> > This patch is not supposed to change the driver behavior, it's only a
> > matter of reorganizing the code.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/Makefile        |    6 +-
> >  drivers/tee/optee/call.c          |  339 +-------
> >  drivers/tee/optee/core.c          |  684 +--------------
> >  drivers/tee/optee/optee_private.h |  104 ++-
> >  drivers/tee/optee/rpc.c           |  255 +-----
> >  drivers/tee/optee/shm_pool.c      |   89 --
> >  drivers/tee/optee/shm_pool.h      |   14 -
> >  drivers/tee/optee/smc_abi.c       | 1301 +++++++++++++++++++++++++++++
> >  8 files changed, 1441 insertions(+), 1351 deletions(-)
> >  delete mode 100644 drivers/tee/optee/shm_pool.c
> >  delete mode 100644 drivers/tee/optee/shm_pool.h
> >  create mode 100644 drivers/tee/optee/smc_abi.c
> >
> > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > index 3aa33ea9e6a6..e92f77462f40 100644
> > --- a/drivers/tee/optee/Makefile
> > +++ b/drivers/tee/optee/Makefile
> > @@ -4,8 +4,10 @@ optee-objs += core.o
> >  optee-objs += call.o
> >  optee-objs += rpc.o
> >  optee-objs += supp.o
> > -optee-objs += shm_pool.o
> >  optee-objs += device.o
> >
> > +optee-smc-abi-y = smc_abi.o
> > +optee-objs += $(optee-ffa-abi-y)
> > +
> >  # for tracing framework to find optee_trace.h
> > -CFLAGS_call.o := -I$(src)
> > +CFLAGS_smc_abi.o := -I$(src)
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 00ecd794e59a..3f81c168ed3f 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -2,28 +2,17 @@
> >  /*
> >   * Copyright (c) 2015-2021, Linaro Limited
> >   */
> > -#include <linux/arm-smccc.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> >  #include <linux/mm.h>
> > -#include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <linux/tee_drv.h>
> >  #include <linux/types.h>
> > -#include <linux/uaccess.h>
> >  #include "optee_private.h"
> > -#include "optee_smc.h"
> > -#define CREATE_TRACE_POINTS
> > -#include "optee_trace.h"
> >
> > -struct optee_call_waiter {
> > -       struct list_head list_node;
> > -       struct completion c;
> > -};
> > -
> > -static void optee_cq_wait_init(struct optee_call_queue *cq,
> > -                              struct optee_call_waiter *w)
> > +void optee_cq_wait_init(struct optee_call_queue *cq,
> > +                       struct optee_call_waiter *w)
> >  {
> >         /*
> >          * We're preparing to make a call to secure world. In case we can't
> > @@ -47,8 +36,8 @@ static void optee_cq_wait_init(struct optee_call_queue *cq,
> >         mutex_unlock(&cq->mutex);
> >  }
> >
> > -static void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > -                                        struct optee_call_waiter *w)
> > +void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > +                                 struct optee_call_waiter *w)
> >  {
> >         wait_for_completion(&w->c);
> >
> > @@ -74,8 +63,8 @@ static void optee_cq_complete_one(struct optee_call_queue *cq)
> >         }
> >  }
> >
> > -static void optee_cq_wait_final(struct optee_call_queue *cq,
> > -                               struct optee_call_waiter *w)
> > +void optee_cq_wait_final(struct optee_call_queue *cq,
> > +                        struct optee_call_waiter *w)
> >  {
> >         /*
> >          * We're done with the call to secure world. The thread in secure
> > @@ -115,73 +104,8 @@ static struct optee_session *find_session(struct optee_context_data *ctxdata,
> >         return NULL;
> >  }
> >
> > -/**
> > - * optee_do_call_with_arg() - Do an SMC to OP-TEE in secure world
> > - * @ctx:       calling context
> > - * @arg:       shared memory holding the message to pass to secure world
> > - *
> > - * Does and SMC to OP-TEE in secure world and handles eventual resulting
> > - * Remote Procedure Calls (RPC) from OP-TEE.
> > - *
> > - * Returns return code from secure world, 0 is OK
> > - */
> > -int optee_do_call_with_arg(struct tee_context *ctx, struct tee_shm *arg)
> > -{
> > -       struct optee *optee = tee_get_drvdata(ctx->teedev);
> > -       struct optee_call_waiter w;
> > -       struct optee_rpc_param param = { };
> > -       struct optee_call_ctx call_ctx = { };
> > -       phys_addr_t parg;
> > -       int rc;
> > -
> > -       rc = tee_shm_get_pa(arg, 0, &parg);
> > -       if (rc)
> > -               return rc;
> > -
> > -       param.a0 = OPTEE_SMC_CALL_WITH_ARG;
> > -       reg_pair_from_64(&param.a1, &param.a2, parg);
> > -       /* Initialize waiter */
> > -       optee_cq_wait_init(&optee->call_queue, &w);
> > -       while (true) {
> > -               struct arm_smccc_res res;
> > -
> > -               trace_optee_invoke_fn_begin(&param);
> > -               optee->invoke_fn(param.a0, param.a1, param.a2, param.a3,
> > -                                param.a4, param.a5, param.a6, param.a7,
> > -                                &res);
> > -               trace_optee_invoke_fn_end(&param, &res);
> > -
> > -               if (res.a0 == OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
> > -                       /*
> > -                        * Out of threads in secure world, wait for a thread
> > -                        * become available.
> > -                        */
> > -                       optee_cq_wait_for_completion(&optee->call_queue, &w);
> > -               } else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
> > -                       cond_resched();
> > -                       param.a0 = res.a0;
> > -                       param.a1 = res.a1;
> > -                       param.a2 = res.a2;
> > -                       param.a3 = res.a3;
> > -                       optee_handle_rpc(ctx, &param, &call_ctx);
> > -               } else {
> > -                       rc = res.a0;
> > -                       break;
> > -               }
> > -       }
> > -
> > -       optee_rpc_finalize_call(&call_ctx);
> > -       /*
> > -        * We're done with our thread in secure world, if there's any
> > -        * thread waiters wake up one.
> > -        */
> > -       optee_cq_wait_final(&optee->call_queue, &w);
> > -
> > -       return rc;
> > -}
> > -
> > -static struct tee_shm *get_msg_arg(struct tee_context *ctx, size_t num_params,
> > -                                  struct optee_msg_arg **msg_arg)
> > +struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
> > +                                 struct optee_msg_arg **msg_arg)
> >  {
> >         struct tee_shm *shm;
> >         struct optee_msg_arg *ma;
> > @@ -217,7 +141,7 @@ int optee_open_session(struct tee_context *ctx,
> >         uuid_t client_uuid;
> >
> >         /* +2 for the meta parameters added below */
> > -       shm = get_msg_arg(ctx, arg->num_params + 2, &msg_arg);
> > +       shm = optee_get_msg_arg(ctx, arg->num_params + 2, &msg_arg);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >
> > @@ -290,7 +214,7 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session)
> >         struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_msg_arg *msg_arg;
> >
> > -       shm = get_msg_arg(ctx, 0, &msg_arg);
> > +       shm = optee_get_msg_arg(ctx, 0, &msg_arg);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >
> > @@ -338,7 +262,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >         if (!sess)
> >                 return -EINVAL;
> >
> > -       shm = get_msg_arg(ctx, arg->num_params, &msg_arg);
> > +       shm = optee_get_msg_arg(ctx, arg->num_params, &msg_arg);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >         msg_arg->cmd = OPTEE_MSG_CMD_INVOKE_COMMAND;
> > @@ -384,7 +308,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
> >         if (!sess)
> >                 return -EINVAL;
> >
> > -       shm = get_msg_arg(ctx, 0, &msg_arg);
> > +       shm = optee_get_msg_arg(ctx, 0, &msg_arg);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >
> > @@ -397,152 +321,6 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
> >         return 0;
> >  }
> >
> > -/**
> > - * optee_enable_shm_cache() - Enables caching of some shared memory allocation
> > - *                           in OP-TEE
> > - * @optee:     main service struct
> > - */
> > -void optee_enable_shm_cache(struct optee *optee)
> > -{
> > -       struct optee_call_waiter w;
> > -
> > -       /* We need to retry until secure world isn't busy. */
> > -       optee_cq_wait_init(&optee->call_queue, &w);
> > -       while (true) {
> > -               struct arm_smccc_res res;
> > -
> > -               optee->invoke_fn(OPTEE_SMC_ENABLE_SHM_CACHE, 0, 0, 0, 0, 0, 0,
> > -                                0, &res);
> > -               if (res.a0 == OPTEE_SMC_RETURN_OK)
> > -                       break;
> > -               optee_cq_wait_for_completion(&optee->call_queue, &w);
> > -       }
> > -       optee_cq_wait_final(&optee->call_queue, &w);
> > -}
> > -
> > -/**
> > - * optee_disable_shm_cache() - Disables caching of some shared memory allocation
> > - *                           in OP-TEE
> > - * @optee:     main service struct
> > - */
> > -void optee_disable_shm_cache(struct optee *optee)
> > -{
> > -       struct optee_call_waiter w;
> > -
> > -       /* We need to retry until secure world isn't busy. */
> > -       optee_cq_wait_init(&optee->call_queue, &w);
> > -       while (true) {
> > -               union {
> > -                       struct arm_smccc_res smccc;
> > -                       struct optee_smc_disable_shm_cache_result result;
> > -               } res;
> > -
> > -               optee->invoke_fn(OPTEE_SMC_DISABLE_SHM_CACHE, 0, 0, 0, 0, 0, 0,
> > -                                0, &res.smccc);
> > -               if (res.result.status == OPTEE_SMC_RETURN_ENOTAVAIL)
> > -                       break; /* All shm's freed */
> > -               if (res.result.status == OPTEE_SMC_RETURN_OK) {
> > -                       struct tee_shm *shm;
> > -
> > -                       shm = reg_pair_to_ptr(res.result.shm_upper32,
> > -                                             res.result.shm_lower32);
> > -                       tee_shm_free(shm);
> > -               } else {
> > -                       optee_cq_wait_for_completion(&optee->call_queue, &w);
> > -               }
> > -       }
> > -       optee_cq_wait_final(&optee->call_queue, &w);
> > -}
> > -
> > -#define PAGELIST_ENTRIES_PER_PAGE                              \
> > -       ((OPTEE_MSG_NONCONTIG_PAGE_SIZE / sizeof(u64)) - 1)
> > -
> > -/**
> > - * optee_fill_pages_list() - write list of user pages to given shared
> > - * buffer.
> > - *
> > - * @dst: page-aligned buffer where list of pages will be stored
> > - * @pages: array of pages that represents shared buffer
> > - * @num_pages: number of entries in @pages
> > - * @page_offset: offset of user buffer from page start
> > - *
> > - * @dst should be big enough to hold list of user page addresses and
> > - *     links to the next pages of buffer
> > - */
> > -void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
> > -                          size_t page_offset)
> > -{
> > -       int n = 0;
> > -       phys_addr_t optee_page;
> > -       /*
> > -        * Refer to OPTEE_MSG_ATTR_NONCONTIG description in optee_msg.h
> > -        * for details.
> > -        */
> > -       struct {
> > -               u64 pages_list[PAGELIST_ENTRIES_PER_PAGE];
> > -               u64 next_page_data;
> > -       } *pages_data;
> > -
> > -       /*
> > -        * Currently OP-TEE uses 4k page size and it does not looks
> > -        * like this will change in the future.  On other hand, there are
> > -        * no know ARM architectures with page size < 4k.
> > -        * Thus the next built assert looks redundant. But the following
> > -        * code heavily relies on this assumption, so it is better be
> > -        * safe than sorry.
> > -        */
> > -       BUILD_BUG_ON(PAGE_SIZE < OPTEE_MSG_NONCONTIG_PAGE_SIZE);
> > -
> > -       pages_data = (void *)dst;
> > -       /*
> > -        * If linux page is bigger than 4k, and user buffer offset is
> > -        * larger than 4k/8k/12k/etc this will skip first 4k pages,
> > -        * because they bear no value data for OP-TEE.
> > -        */
> > -       optee_page = page_to_phys(*pages) +
> > -               round_down(page_offset, OPTEE_MSG_NONCONTIG_PAGE_SIZE);
> > -
> > -       while (true) {
> > -               pages_data->pages_list[n++] = optee_page;
> > -
> > -               if (n == PAGELIST_ENTRIES_PER_PAGE) {
> > -                       pages_data->next_page_data =
> > -                               virt_to_phys(pages_data + 1);
> > -                       pages_data++;
> > -                       n = 0;
> > -               }
> > -
> > -               optee_page += OPTEE_MSG_NONCONTIG_PAGE_SIZE;
> > -               if (!(optee_page & ~PAGE_MASK)) {
> > -                       if (!--num_pages)
> > -                               break;
> > -                       pages++;
> > -                       optee_page = page_to_phys(*pages);
> > -               }
> > -       }
> > -}
> > -
> > -/*
> > - * The final entry in each pagelist page is a pointer to the next
> > - * pagelist page.
> > - */
> > -static size_t get_pages_list_size(size_t num_entries)
> > -{
> > -       int pages = DIV_ROUND_UP(num_entries, PAGELIST_ENTRIES_PER_PAGE);
> > -
> > -       return pages * OPTEE_MSG_NONCONTIG_PAGE_SIZE;
> > -}
> > -
> > -u64 *optee_allocate_pages_list(size_t num_entries)
> > -{
> > -       return alloc_pages_exact(get_pages_list_size(num_entries), GFP_KERNEL);
> > -}
> > -
> > -void optee_free_pages_list(void *list, size_t num_entries)
> > -{
> > -       free_pages_exact(list, get_pages_list_size(num_entries));
> > -}
> > -
> >  static bool is_normal_memory(pgprot_t p)
> >  {
> >  #if defined(CONFIG_ARM)
> > @@ -566,7 +344,7 @@ static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
> >         return -EINVAL;
> >  }
> >
> > -static int check_mem_type(unsigned long start, size_t num_pages)
> > +int optee_check_mem_type(unsigned long start, size_t num_pages)
> >  {
> >         struct mm_struct *mm = current->mm;
> >         int rc;
> > @@ -585,94 +363,3 @@ static int check_mem_type(unsigned long start, size_t num_pages)
> >
> >         return rc;
> >  }
> > -
> > -int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> > -                      struct page **pages, size_t num_pages,
> > -                      unsigned long start)
> > -{
> > -       struct optee *optee = tee_get_drvdata(ctx->teedev);
> > -       struct optee_msg_arg *msg_arg;
> > -       struct tee_shm *shm_arg;
> > -       u64 *pages_list;
> > -       int rc;
> > -
> > -       if (!num_pages)
> > -               return -EINVAL;
> > -
> > -       rc = check_mem_type(start, num_pages);
> > -       if (rc)
> > -               return rc;
> > -
> > -       pages_list = optee_allocate_pages_list(num_pages);
> > -       if (!pages_list)
> > -               return -ENOMEM;
> > -
> > -       shm_arg = get_msg_arg(ctx, 1, &msg_arg);
> > -       if (IS_ERR(shm_arg)) {
> > -               rc = PTR_ERR(shm_arg);
> > -               goto out;
> > -       }
> > -
> > -       optee_fill_pages_list(pages_list, pages, num_pages,
> > -                             tee_shm_get_page_offset(shm));
> > -
> > -       msg_arg->cmd = OPTEE_MSG_CMD_REGISTER_SHM;
> > -       msg_arg->params->attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
> > -                               OPTEE_MSG_ATTR_NONCONTIG;
> > -       msg_arg->params->u.tmem.shm_ref = (unsigned long)shm;
> > -       msg_arg->params->u.tmem.size = tee_shm_get_size(shm);
> > -       /*
> > -        * In the least bits of msg_arg->params->u.tmem.buf_ptr we
> > -        * store buffer offset from 4k page, as described in OP-TEE ABI.
> > -        */
> > -       msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
> > -         (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> > -
> > -       if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
> > -           msg_arg->ret != TEEC_SUCCESS)
> > -               rc = -EINVAL;
> > -
> > -       tee_shm_free(shm_arg);
> > -out:
> > -       optee_free_pages_list(pages_list, num_pages);
> > -       return rc;
> > -}
> > -
> > -int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
> > -{
> > -       struct optee *optee = tee_get_drvdata(ctx->teedev);
> > -       struct optee_msg_arg *msg_arg;
> > -       struct tee_shm *shm_arg;
> > -       int rc = 0;
> > -
> > -       shm_arg = get_msg_arg(ctx, 1, &msg_arg);
> > -       if (IS_ERR(shm_arg))
> > -               return PTR_ERR(shm_arg);
> > -
> > -       msg_arg->cmd = OPTEE_MSG_CMD_UNREGISTER_SHM;
> > -
> > -       msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> > -       msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
> > -
> > -       if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
> > -           msg_arg->ret != TEEC_SUCCESS)
> > -               rc = -EINVAL;
> > -       tee_shm_free(shm_arg);
> > -       return rc;
> > -}
> > -
> > -int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
> > -                           struct page **pages, size_t num_pages,
> > -                           unsigned long start)
> > -{
> > -       /*
> > -        * We don't want to register supplicant memory in OP-TEE.
> > -        * Instead information about it will be passed in RPC code.
> > -        */
> > -       return check_mem_type(start, num_pages);
> > -}
> > -
> > -int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm)
> > -{
> > -       return 0;
> > -}
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index f689f171a794..e0dcde043df2 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -1,259 +1,62 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * Copyright (c) 2015-2021, Linaro Limited
> > + * Copyright (c) 2016, EPAM Systems
> >   */
> >
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > -#include <linux/arm-smccc.h>
> >  #include <linux/errno.h>
> >  #include <linux/io.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> > -#include <linux/of.h>
> > -#include <linux/of_platform.h>
> > -#include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/tee_drv.h>
> >  #include <linux/types.h>
> > -#include <linux/uaccess.h>
> >  #include <linux/workqueue.h>
> >  #include "optee_private.h"
> > -#include "optee_smc.h"
> > -#include "shm_pool.h"
> >
> > -#define DRIVER_NAME "optee"
> > -
> > -#define OPTEE_SHM_NUM_PRIV_PAGES       CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
> > -
> > -static void from_msg_param_value(struct tee_param *p, u32 attr,
> > -                                const struct optee_msg_param *mp)
> > -{
> > -       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
> > -                 attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
> > -       p->u.value.a = mp->u.value.a;
> > -       p->u.value.b = mp->u.value.b;
> > -       p->u.value.c = mp->u.value.c;
> > -}
> > -
> > -static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
> > -                                 const struct optee_msg_param *mp)
> > +int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
> > +                              struct tee_shm *shm, size_t size,
> > +                              int (*shm_register)(struct tee_context *ctx,
> > +                                                  struct tee_shm *shm,
> > +                                                  struct page **pages,
> > +                                                  size_t num_pages,
> > +                                                  unsigned long start))
> >  {
> > -       struct tee_shm *shm;
> > -       phys_addr_t pa;
> > -       int rc;
> > -
> > -       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> > -                 attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
> > -       p->u.memref.size = mp->u.tmem.size;
> > -       shm = (struct tee_shm *)(unsigned long)mp->u.tmem.shm_ref;
> > -       if (!shm) {
> > -               p->u.memref.shm_offs = 0;
> > -               p->u.memref.shm = NULL;
> > -               return 0;
> > -       }
> > -
> > -       rc = tee_shm_get_pa(shm, 0, &pa);
> > -       if (rc)
> > -               return rc;
> > -
> > -       p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
> > -       p->u.memref.shm = shm;
> > -
> > -       /* Check that the memref is covered by the shm object */
> > -       if (p->u.memref.size) {
> > -               size_t o = p->u.memref.shm_offs +
> > -                          p->u.memref.size - 1;
> > -
> > -               rc = tee_shm_get_pa(shm, o, NULL);
> > -               if (rc)
> > -                       return rc;
> > -       }
> > +       unsigned int order = get_order(size);
> > +       struct page *page;
> > +       int rc = 0;
> >
> > -       return 0;
> > -}
> > -
> > -static void from_msg_param_reg_mem(struct tee_param *p, u32 attr,
> > -                                  const struct optee_msg_param *mp)
> > -{
> > -       struct tee_shm *shm;
> > -
> > -       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> > -                 attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> > -       p->u.memref.size = mp->u.rmem.size;
> > -       shm = (struct tee_shm *)(unsigned long)mp->u.rmem.shm_ref;
> > -
> > -       if (shm) {
> > -               p->u.memref.shm_offs = mp->u.rmem.offs;
> > -               p->u.memref.shm = shm;
> > -       } else {
> > -               p->u.memref.shm_offs = 0;
> > -               p->u.memref.shm = NULL;
> > -       }
> > -}
> > +       page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> > +       if (!page)
> > +               return -ENOMEM;
> >
> > -/**
> > - * optee_from_msg_param() - convert from OPTEE_MSG parameters to
> > - *                         struct tee_param
> > - * @optee:     main service struct
> > - * @params:    subsystem internal parameter representation
> > - * @num_params:        number of elements in the parameter arrays
> > - * @msg_params:        OPTEE_MSG parameters
> > - * Returns 0 on success or <0 on failure
> > - */
> > -static int optee_from_msg_param(struct optee *optee, struct tee_param *params,
> > -                               size_t num_params,
> > -                               const struct optee_msg_param *msg_params)
> > -{
> > -       int rc;
> > -       size_t n;
> > +       shm->kaddr = page_address(page);
> > +       shm->paddr = page_to_phys(page);
> > +       shm->size = PAGE_SIZE << order;
> >
> > -       for (n = 0; n < num_params; n++) {
> > -               struct tee_param *p = params + n;
> > -               const struct optee_msg_param *mp = msg_params + n;
> > -               u32 attr = mp->attr & OPTEE_MSG_ATTR_TYPE_MASK;
> > +       if (shm_register) {
> > +               unsigned int nr_pages = 1 << order, i;
> > +               struct page **pages;
> >
> > -               switch (attr) {
> > -               case OPTEE_MSG_ATTR_TYPE_NONE:
> > -                       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> > -                       memset(&p->u, 0, sizeof(p->u));
> > -                       break;
> > -               case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
> > -               case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
> > -               case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
> > -                       from_msg_param_value(p, attr, mp);
> > -                       break;
> > -               case OPTEE_MSG_ATTR_TYPE_TMEM_INPUT:
> > -               case OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT:
> > -               case OPTEE_MSG_ATTR_TYPE_TMEM_INOUT:
> > -                       rc = from_msg_param_tmp_mem(p, attr, mp);
> > -                       if (rc)
> > -                               return rc;
> > -                       break;
> > -               case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
> > -               case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
> > -               case OPTEE_MSG_ATTR_TYPE_RMEM_INOUT:
> > -                       from_msg_param_reg_mem(p, attr, mp);
> > -                       break;
> > +               pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
> > +               if (!pages)
> > +                       return -ENOMEM;
> >
> > -               default:
> > -                       return -EINVAL;
> > +               for (i = 0; i < nr_pages; i++) {
> > +                       pages[i] = page;
> > +                       page++;
> >                 }
> > -       }
> > -       return 0;
> > -}
> > -
> > -static void to_msg_param_value(struct optee_msg_param *mp,
> > -                              const struct tee_param *p)
> > -{
> > -       mp->attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
> > -                  TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> > -       mp->u.value.a = p->u.value.a;
> > -       mp->u.value.b = p->u.value.b;
> > -       mp->u.value.c = p->u.value.c;
> > -}
> >
> > -static int to_msg_param_tmp_mem(struct optee_msg_param *mp,
> > -                               const struct tee_param *p)
> > -{
> > -       int rc;
> > -       phys_addr_t pa;
> > -
> > -       mp->attr = OPTEE_MSG_ATTR_TYPE_TMEM_INPUT + p->attr -
> > -                  TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > -
> > -       mp->u.tmem.shm_ref = (unsigned long)p->u.memref.shm;
> > -       mp->u.tmem.size = p->u.memref.size;
> > -
> > -       if (!p->u.memref.shm) {
> > -               mp->u.tmem.buf_ptr = 0;
> > -               return 0;
> > +               shm->flags |= TEE_SHM_REGISTER;
> > +               rc = shm_register(shm->ctx, shm, pages, nr_pages,
> > +                                 (unsigned long)shm->kaddr);
> > +               kfree(pages);
> >         }
> >
> > -       rc = tee_shm_get_pa(p->u.memref.shm, p->u.memref.shm_offs, &pa);
> > -       if (rc)
> > -               return rc;
> > -
> > -       mp->u.tmem.buf_ptr = pa;
> > -       mp->attr |= OPTEE_MSG_ATTR_CACHE_PREDEFINED <<
> > -                   OPTEE_MSG_ATTR_CACHE_SHIFT;
> > -
> > -       return 0;
> > -}
> > -
> > -static int to_msg_param_reg_mem(struct optee_msg_param *mp,
> > -                               const struct tee_param *p)
> > -{
> > -       mp->attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT + p->attr -
> > -                  TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > -
> > -       mp->u.rmem.shm_ref = (unsigned long)p->u.memref.shm;
> > -       mp->u.rmem.size = p->u.memref.size;
> > -       mp->u.rmem.offs = p->u.memref.shm_offs;
> > -       return 0;
> > -}
> > -
> > -/**
> > - * optee_to_msg_param() - convert from struct tee_params to OPTEE_MSG parameters
> > - * @optee:     main service struct
> > - * @msg_params:        OPTEE_MSG parameters
> > - * @num_params:        number of elements in the parameter arrays
> > - * @params:    subsystem itnernal parameter representation
> > - * Returns 0 on success or <0 on failure
> > - */
> > -static int optee_to_msg_param(struct optee *optee,
> > -                             struct optee_msg_param *msg_params,
> > -                             size_t num_params, const struct tee_param *params)
> > -{
> > -       int rc;
> > -       size_t n;
> > -
> > -       for (n = 0; n < num_params; n++) {
> > -               const struct tee_param *p = params + n;
> > -               struct optee_msg_param *mp = msg_params + n;
> > -
> > -               switch (p->attr) {
> > -               case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
> > -                       mp->attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> > -                       memset(&mp->u, 0, sizeof(mp->u));
> > -                       break;
> > -               case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
> > -               case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
> > -               case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
> > -                       to_msg_param_value(mp, p);
> > -                       break;
> > -               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
> > -               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
> > -               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> > -                       if (tee_shm_is_registered(p->u.memref.shm))
> > -                               rc = to_msg_param_reg_mem(mp, p);
> > -                       else
> > -                               rc = to_msg_param_tmp_mem(mp, p);
> > -                       if (rc)
> > -                               return rc;
> > -                       break;
> > -               default:
> > -                       return -EINVAL;
> > -               }
> > -       }
> > -       return 0;
> > -}
> > -
> > -static void optee_get_version(struct tee_device *teedev,
> > -                             struct tee_ioctl_version_data *vers)
> > -{
> > -       struct tee_ioctl_version_data v = {
> > -               .impl_id = TEE_IMPL_ID_OPTEE,
> > -               .impl_caps = TEE_OPTEE_CAP_TZ,
> > -               .gen_caps = TEE_GEN_CAP_GP,
> > -       };
> > -       struct optee *optee = tee_get_drvdata(teedev);
> > -
> > -       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> > -               v.gen_caps |= TEE_GEN_CAP_REG_MEM;
> > -       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
> > -               v.gen_caps |= TEE_GEN_CAP_MEMREF_NULL;
> > -       *vers = v;
> > +       return rc;
> >  }
> >
> >  static void optee_bus_scan(struct work_struct *work)
> > @@ -261,7 +64,7 @@ static void optee_bus_scan(struct work_struct *work)
> >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> >  }
> >
> > -static int optee_open(struct tee_context *ctx)
> > +int optee_open(struct tee_context *ctx, bool cap_memref_null)
> >  {
> >         struct optee_context_data *ctxdata;
> >         struct tee_device *teedev = ctx->teedev;
> > @@ -299,11 +102,7 @@ static int optee_open(struct tee_context *ctx)
> >         mutex_init(&ctxdata->mutex);
> >         INIT_LIST_HEAD(&ctxdata->sess_list);
> >
> > -       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
> > -               ctx->cap_memref_null  = true;
> > -       else
> > -               ctx->cap_memref_null = false;
> > -
> > +       ctx->cap_memref_null = cap_memref_null;
> >         ctx->data = ctxdata;
> >         return 0;
> >  }
> > @@ -329,12 +128,12 @@ static void optee_release_helper(struct tee_context *ctx,
> >         ctx->data = NULL;
> >  }
> >
> > -static void optee_release(struct tee_context *ctx)
> > +void optee_release(struct tee_context *ctx)
> >  {
> >         optee_release_helper(ctx, optee_close_session_helper);
> >  }
> >
> > -static void optee_release_supp(struct tee_context *ctx)
> > +void optee_release_supp(struct tee_context *ctx)
> >  {
> >         struct optee *optee = tee_get_drvdata(ctx->teedev);
> >
> > @@ -346,277 +145,8 @@ static void optee_release_supp(struct tee_context *ctx)
> >         optee_supp_release(&optee->supp);
> >  }
> >
> > -static const struct tee_driver_ops optee_clnt_ops = {
> > -       .get_version = optee_get_version,
> > -       .open = optee_open,
> > -       .release = optee_release,
> > -       .open_session = optee_open_session,
> > -       .close_session = optee_close_session,
> > -       .invoke_func = optee_invoke_func,
> > -       .cancel_req = optee_cancel_req,
> > -       .shm_register = optee_shm_register,
> > -       .shm_unregister = optee_shm_unregister,
> > -};
> > -
> > -static const struct tee_desc optee_clnt_desc = {
> > -       .name = DRIVER_NAME "-clnt",
> > -       .ops = &optee_clnt_ops,
> > -       .owner = THIS_MODULE,
> > -};
> > -
> > -static const struct tee_driver_ops optee_supp_ops = {
> > -       .get_version = optee_get_version,
> > -       .open = optee_open,
> > -       .release = optee_release_supp,
> > -       .supp_recv = optee_supp_recv,
> > -       .supp_send = optee_supp_send,
> > -       .shm_register = optee_shm_register_supp,
> > -       .shm_unregister = optee_shm_unregister_supp,
> > -};
> > -
> > -static const struct tee_desc optee_supp_desc = {
> > -       .name = DRIVER_NAME "-supp",
> > -       .ops = &optee_supp_ops,
> > -       .owner = THIS_MODULE,
> > -       .flags = TEE_DESC_PRIVILEGED,
> > -};
> > -
> > -static const struct optee_ops optee_ops = {
> > -       .do_call_with_arg = optee_do_call_with_arg,
> > -       .to_msg_param = optee_to_msg_param,
> > -       .from_msg_param = optee_from_msg_param,
> > -};
> > -
> > -static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
> > -{
> > -       struct arm_smccc_res res;
> > -
> > -       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> > -
> > -       if (res.a0 == OPTEE_MSG_UID_0 && res.a1 == OPTEE_MSG_UID_1 &&
> > -           res.a2 == OPTEE_MSG_UID_2 && res.a3 == OPTEE_MSG_UID_3)
> > -               return true;
> > -       return false;
> > -}
> > -
> > -static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> > -{
> > -       union {
> > -               struct arm_smccc_res smccc;
> > -               struct optee_smc_call_get_os_revision_result result;
> > -       } res = {
> > -               .result = {
> > -                       .build_id = 0
> > -               }
> > -       };
> > -
> > -       invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
> > -                 &res.smccc);
> > -
> > -       if (res.result.build_id)
> > -               pr_info("revision %lu.%lu (%08lx)", res.result.major,
> > -                       res.result.minor, res.result.build_id);
> > -       else
> > -               pr_info("revision %lu.%lu", res.result.major, res.result.minor);
> > -}
> > -
> > -static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
> > -{
> > -       union {
> > -               struct arm_smccc_res smccc;
> > -               struct optee_smc_calls_revision_result result;
> > -       } res;
> > -
> > -       invoke_fn(OPTEE_SMC_CALLS_REVISION, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
> > -
> > -       if (res.result.major == OPTEE_MSG_REVISION_MAJOR &&
> > -           (int)res.result.minor >= OPTEE_MSG_REVISION_MINOR)
> > -               return true;
> > -       return false;
> > -}
> > -
> > -static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> > -                                           u32 *sec_caps)
> > -{
> > -       union {
> > -               struct arm_smccc_res smccc;
> > -               struct optee_smc_exchange_capabilities_result result;
> > -       } res;
> > -       u32 a1 = 0;
> > -
> > -       /*
> > -        * TODO This isn't enough to tell if it's UP system (from kernel
> > -        * point of view) or not, is_smp() returns the the information
> > -        * needed, but can't be called directly from here.
> > -        */
> > -       if (!IS_ENABLED(CONFIG_SMP) || nr_cpu_ids == 1)
> > -               a1 |= OPTEE_SMC_NSEC_CAP_UNIPROCESSOR;
> > -
> > -       invoke_fn(OPTEE_SMC_EXCHANGE_CAPABILITIES, a1, 0, 0, 0, 0, 0, 0,
> > -                 &res.smccc);
> > -
> > -       if (res.result.status != OPTEE_SMC_RETURN_OK)
> > -               return false;
> > -
> > -       *sec_caps = res.result.capabilities;
> > -       return true;
> > -}
> > -
> > -static struct tee_shm_pool *optee_config_dyn_shm(void)
> > -{
> > -       struct tee_shm_pool_mgr *priv_mgr;
> > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> > -       void *rc;
> > -
> > -       rc = optee_shm_pool_alloc_pages();
> > -       if (IS_ERR(rc))
> > -               return rc;
> > -       priv_mgr = rc;
> > -
> > -       rc = optee_shm_pool_alloc_pages();
> > -       if (IS_ERR(rc)) {
> > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > -               return rc;
> > -       }
> > -       dmabuf_mgr = rc;
> > -
> > -       rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -       if (IS_ERR(rc)) {
> > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > -               tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -       }
> > -
> > -       return rc;
> > -}
> > -
> > -static struct tee_shm_pool *
> > -optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
> > +void optee_remove_common(struct optee *optee)
> >  {
> > -       union {
> > -               struct arm_smccc_res smccc;
> > -               struct optee_smc_get_shm_config_result result;
> > -       } res;
> > -       unsigned long vaddr;
> > -       phys_addr_t paddr;
> > -       size_t size;
> > -       phys_addr_t begin;
> > -       phys_addr_t end;
> > -       void *va;
> > -       struct tee_shm_pool_mgr *priv_mgr;
> > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> > -       void *rc;
> > -       const int sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> > -
> > -       invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
> > -       if (res.result.status != OPTEE_SMC_RETURN_OK) {
> > -               pr_err("static shm service not available\n");
> > -               return ERR_PTR(-ENOENT);
> > -       }
> > -
> > -       if (res.result.settings != OPTEE_SMC_SHM_CACHED) {
> > -               pr_err("only normal cached shared memory supported\n");
> > -               return ERR_PTR(-EINVAL);
> > -       }
> > -
> > -       begin = roundup(res.result.start, PAGE_SIZE);
> > -       end = rounddown(res.result.start + res.result.size, PAGE_SIZE);
> > -       paddr = begin;
> > -       size = end - begin;
> > -
> > -       if (size < 2 * OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE) {
> > -               pr_err("too small shared memory area\n");
> > -               return ERR_PTR(-EINVAL);
> > -       }
> > -
> > -       va = memremap(paddr, size, MEMREMAP_WB);
> > -       if (!va) {
> > -               pr_err("shared memory ioremap failed\n");
> > -               return ERR_PTR(-EINVAL);
> > -       }
> > -       vaddr = (unsigned long)va;
> > -
> > -       rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> > -                                           3 /* 8 bytes aligned */);
> > -       if (IS_ERR(rc))
> > -               goto err_memunmap;
> > -       priv_mgr = rc;
> > -
> > -       vaddr += sz;
> > -       paddr += sz;
> > -       size -= sz;
> > -
> > -       rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
> > -       if (IS_ERR(rc))
> > -               goto err_free_priv_mgr;
> > -       dmabuf_mgr = rc;
> > -
> > -       rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -       if (IS_ERR(rc))
> > -               goto err_free_dmabuf_mgr;
> > -
> > -       *memremaped_shm = va;
> > -
> > -       return rc;
> > -
> > -err_free_dmabuf_mgr:
> > -       tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -err_free_priv_mgr:
> > -       tee_shm_pool_mgr_destroy(priv_mgr);
> > -err_memunmap:
> > -       memunmap(va);
> > -       return rc;
> > -}
> > -
> > -/* Simple wrapper functions to be able to use a function pointer */
> > -static void optee_smccc_smc(unsigned long a0, unsigned long a1,
> > -                           unsigned long a2, unsigned long a3,
> > -                           unsigned long a4, unsigned long a5,
> > -                           unsigned long a6, unsigned long a7,
> > -                           struct arm_smccc_res *res)
> > -{
> > -       arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
> > -}
> > -
> > -static void optee_smccc_hvc(unsigned long a0, unsigned long a1,
> > -                           unsigned long a2, unsigned long a3,
> > -                           unsigned long a4, unsigned long a5,
> > -                           unsigned long a6, unsigned long a7,
> > -                           struct arm_smccc_res *res)
> > -{
> > -       arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
> > -}
> > -
> > -static optee_invoke_fn *get_invoke_func(struct device *dev)
> > -{
> > -       const char *method;
> > -
> > -       pr_info("probing for conduit method.\n");
> > -
> > -       if (device_property_read_string(dev, "method", &method)) {
> > -               pr_warn("missing \"method\" property\n");
> > -               return ERR_PTR(-ENXIO);
> > -       }
> > -
> > -       if (!strcmp("hvc", method))
> > -               return optee_smccc_hvc;
> > -       else if (!strcmp("smc", method))
> > -               return optee_smccc_smc;
> > -
> > -       pr_warn("invalid \"method\" property: %s\n", method);
> > -       return ERR_PTR(-EINVAL);
> > -}
> > -
> > -static int optee_remove(struct platform_device *pdev)
> > -{
> > -       struct optee *optee = platform_get_drvdata(pdev);
> > -
> > -       /*
> > -        * Ask OP-TEE to free all cached shared memory objects to decrease
> > -        * reference counters and also avoid wild pointers in secure world
> > -        * into the old shared memory range.
> > -        */
> > -       optee_disable_shm_cache(optee);
> > -
> >         /*
> >          * The two devices have to be unregistered before we can free the
> >          * other resources.
> > @@ -625,151 +155,11 @@ static int optee_remove(struct platform_device *pdev)
> >         tee_device_unregister(optee->teedev);
> >
> >         tee_shm_pool_free(optee->pool);
> > -       if (optee->memremaped_shm)
> > -               memunmap(optee->memremaped_shm);
> >         optee_wait_queue_exit(&optee->wait_queue);
> >         optee_supp_uninit(&optee->supp);
> >         mutex_destroy(&optee->call_queue.mutex);
> > -
> > -       kfree(optee);
> > -
> > -       return 0;
> > -}
> > -
> > -static int optee_probe(struct platform_device *pdev)
> > -{
> > -       optee_invoke_fn *invoke_fn;
> > -       struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
> > -       struct optee *optee = NULL;
> > -       void *memremaped_shm = NULL;
> > -       struct tee_device *teedev;
> > -       u32 sec_caps;
> > -       int rc;
> > -
> > -       invoke_fn = get_invoke_func(&pdev->dev);
> > -       if (IS_ERR(invoke_fn))
> > -               return PTR_ERR(invoke_fn);
> > -
> > -       if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> > -               pr_warn("api uid mismatch\n");
> > -               return -EINVAL;
> > -       }
> > -
> > -       optee_msg_get_os_revision(invoke_fn);
> > -
> > -       if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
> > -               pr_warn("api revision mismatch\n");
> > -               return -EINVAL;
> > -       }
> > -
> > -       if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps)) {
> > -               pr_warn("capabilities mismatch\n");
> > -               return -EINVAL;
> > -       }
> > -
> > -       /*
> > -        * Try to use dynamic shared memory if possible
> > -        */
> > -       if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> > -               pool = optee_config_dyn_shm();
> > -
> > -       /*
> > -        * If dynamic shared memory is not available or failed - try static one
> > -        */
> > -       if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
> > -               pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm);
> > -
> > -       if (IS_ERR(pool))
> > -               return PTR_ERR(pool);
> > -
> > -       optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> > -       if (!optee) {
> > -               rc = -ENOMEM;
> > -               goto err;
> > -       }
> > -
> > -       optee->ops = &optee_ops;
> > -       optee->invoke_fn = invoke_fn;
> > -       optee->sec_caps = sec_caps;
> > -
> > -       teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
> > -       if (IS_ERR(teedev)) {
> > -               rc = PTR_ERR(teedev);
> > -               goto err;
> > -       }
> > -       optee->teedev = teedev;
> > -
> > -       teedev = tee_device_alloc(&optee_supp_desc, NULL, pool, optee);
> > -       if (IS_ERR(teedev)) {
> > -               rc = PTR_ERR(teedev);
> > -               goto err;
> > -       }
> > -       optee->supp_teedev = teedev;
> > -
> > -       rc = tee_device_register(optee->teedev);
> > -       if (rc)
> > -               goto err;
> > -
> > -       rc = tee_device_register(optee->supp_teedev);
> > -       if (rc)
> > -               goto err;
> > -
> > -       mutex_init(&optee->call_queue.mutex);
> > -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> > -       optee_wait_queue_init(&optee->wait_queue);
> > -       optee_supp_init(&optee->supp);
> > -       optee->memremaped_shm = memremaped_shm;
> > -       optee->pool = pool;
> > -
> > -       optee_enable_shm_cache(optee);
> > -
> > -       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> > -               pr_info("dynamic shared memory is enabled\n");
> > -
> > -       platform_set_drvdata(pdev, optee);
> > -
> > -       rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
> > -       if (rc) {
> > -               optee_remove(pdev);
> > -               return rc;
> > -       }
> > -
> > -       pr_info("initialized driver\n");
> > -       return 0;
> > -err:
> > -       if (optee) {
> > -               /*
> > -                * tee_device_unregister() is safe to call even if the
> > -                * devices hasn't been registered with
> > -                * tee_device_register() yet.
> > -                */
> > -               tee_device_unregister(optee->supp_teedev);
> > -               tee_device_unregister(optee->teedev);
> > -               kfree(optee);
> > -       }
> > -       if (pool)
> > -               tee_shm_pool_free(pool);
> > -       if (memremaped_shm)
> > -               memunmap(memremaped_shm);
> > -       return rc;
> >  }
> >
> > -static const struct of_device_id optee_dt_match[] = {
> > -       { .compatible = "linaro,optee-tz" },
> > -       {},
> > -};
> > -MODULE_DEVICE_TABLE(of, optee_dt_match);
> > -
> > -static struct platform_driver optee_driver = {
> > -       .probe  = optee_probe,
> > -       .remove = optee_remove,
> > -       .driver = {
> > -               .name = "optee",
> > -               .of_match_table = optee_dt_match,
> > -       },
> > -};
> > -module_platform_driver(optee_driver);
> > -
> >  MODULE_AUTHOR("Linaro");
> >  MODULE_DESCRIPTION("OP-TEE driver");
> >  MODULE_VERSION("1.0");
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index c5741e96e967..68d1331068e9 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -12,6 +12,8 @@
> >  #include <linux/types.h>
> >  #include "optee_msg.h"
> >
> > +#define DRIVER_NAME "optee"
> > +
> >  #define OPTEE_MAX_ARG_SIZE     1024
> >
> >  /* Some Global Platform error codes used in this driver */
> > @@ -29,6 +31,11 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
> >                                 unsigned long, unsigned long,
> >                                 struct arm_smccc_res *);
> >
> > +struct optee_call_waiter {
> > +       struct list_head list_node;
> > +       struct completion c;
> > +};
> > +
> >  struct optee_call_queue {
> >         /* Serializes access to this struct */
> >         struct mutex mutex;
> > @@ -66,6 +73,19 @@ struct optee_supp {
> >         struct completion reqs_c;
> >  };
> >
> > +/**
> > + * struct optee_smc - SMC ABI specifics
> > + * @invoke_fn:         function to issue smc or hvc
> > + * @memremaped_shm     virtual address of memory in shared memory pool
> > + * @sec_caps:          secure world capabilities defined by
> > + *                     OPTEE_SMC_SEC_CAP_* in optee_smc.h
> > + */
> > +struct optee_smc {
> > +       optee_invoke_fn *invoke_fn;
> > +       void *memremaped_shm;
> > +       u32 sec_caps;
> > +};
> > +
> >  struct optee;
> >
> >  /**
> > @@ -95,15 +115,12 @@ struct optee_ops {
> >   * @ops:               internal callbacks for different ways to reach secure
> >   *                     world
> >   * @teedev:            client device
> > - * @invoke_fn:         function to issue smc or hvc
> > + * @smc:               specific to SMC ABI
> >   * @call_queue:                queue of threads waiting to call @invoke_fn
> >   * @wait_queue:                queue of threads from secure world waiting for a
> >   *                     secure world sync object
> >   * @supp:              supplicant synchronization struct for RPC to supplicant
> >   * @pool:              shared memory pool
> > - * @memremaped_shm     virtual address of memory in shared memory pool
> > - * @sec_caps:          secure world capabilities defined by
> > - *                     OPTEE_SMC_SEC_CAP_* in optee_smc.h
> >   * @scan_bus_done      flag if device registation was already done.
> >   * @scan_bus_wq                workqueue to scan optee bus and register optee drivers
> >   * @scan_bus_work      workq to scan optee bus and register optee drivers
> > @@ -112,13 +129,11 @@ struct optee {
> >         struct tee_device *supp_teedev;
> >         struct tee_device *teedev;
> >         const struct optee_ops *ops;
> > -       optee_invoke_fn *invoke_fn;
> > +       struct optee_smc smc;
> >         struct optee_call_queue call_queue;
> >         struct optee_wait_queue wait_queue;
> >         struct optee_supp supp;
> >         struct tee_shm_pool *pool;
> > -       void *memremaped_shm;
> > -       u32 sec_caps;
> >         bool   scan_bus_done;
> >         struct workqueue_struct *scan_bus_wq;
> >         struct work_struct scan_bus_work;
> > @@ -153,10 +168,6 @@ struct optee_call_ctx {
> >         size_t num_entries;
> >  };
> >
> > -void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> > -                     struct optee_call_ctx *call_ctx);
> > -void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx);
> > -
> >  void optee_wait_queue_init(struct optee_wait_queue *wq);
> >  void optee_wait_queue_exit(struct optee_wait_queue *wq);
> >
> > @@ -174,7 +185,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
> >  int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
> >                     struct tee_param *param);
> >
> > -int optee_do_call_with_arg(struct tee_context *ctx, struct tee_shm *arg);
> >  int optee_open_session(struct tee_context *ctx,
> >                        struct tee_ioctl_open_session_arg *arg,
> >                        struct tee_param *param);
> > @@ -184,27 +194,63 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >                       struct tee_param *param);
> >  int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
> >
> > -void optee_enable_shm_cache(struct optee *optee);
> > -void optee_disable_shm_cache(struct optee *optee);
> > +#define PTA_CMD_GET_DEVICES            0x0
> > +#define PTA_CMD_GET_DEVICES_SUPP       0x1
> > +int optee_enumerate_devices(u32 func);
> >
> > -int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> > -                      struct page **pages, size_t num_pages,
> > -                      unsigned long start);
> > -int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm);
> > +int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
> > +                              struct tee_shm *shm, size_t size,
> > +                              int (*shm_register)(struct tee_context *ctx,
> > +                                                  struct tee_shm *shm,
> > +                                                  struct page **pages,
> > +                                                  size_t num_pages,
> > +                                                  unsigned long start));
> >
> > -int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
> > -                           struct page **pages, size_t num_pages,
> > -                           unsigned long start);
> > -int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm);
> >
> > -u64 *optee_allocate_pages_list(size_t num_entries);
> > -void optee_free_pages_list(void *array, size_t num_entries);
> > -void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
> > -                          size_t page_offset);
> > +void optee_remove_common(struct optee *optee);
> > +int optee_open(struct tee_context *ctx, bool cap_memref_null);
> > +void optee_release(struct tee_context *ctx);
> > +void optee_release_supp(struct tee_context *ctx);
> >
> > -#define PTA_CMD_GET_DEVICES            0x0
> > -#define PTA_CMD_GET_DEVICES_SUPP       0x1
> > -int optee_enumerate_devices(u32 func);
> > +static inline void optee_from_msg_param_value(struct tee_param *p, u32 attr,
> > +                                             const struct optee_msg_param *mp)
> > +{
> > +       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
> > +                 attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
> > +       p->u.value.a = mp->u.value.a;
> > +       p->u.value.b = mp->u.value.b;
> > +       p->u.value.c = mp->u.value.c;
> > +}
> > +
> > +static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
> > +                                           const struct tee_param *p)
> > +{
> > +       mp->attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
> > +                  TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> > +       mp->u.value.a = p->u.value.a;
> > +       mp->u.value.b = p->u.value.b;
> > +       mp->u.value.c = p->u.value.c;
> > +}
> > +
> > +void optee_cq_wait_init(struct optee_call_queue *cq,
> > +                       struct optee_call_waiter *w);
> > +void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > +                                 struct optee_call_waiter *w);
> > +void optee_cq_wait_final(struct optee_call_queue *cq,
> > +                        struct optee_call_waiter *w);
> > +int optee_check_mem_type(unsigned long start, size_t num_pages);
> > +struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
> > +                                 struct optee_msg_arg **msg_arg);
> > +
> > +struct tee_shm *optee_rpc_cmd_alloc_suppl(struct tee_context *ctx, size_t sz);
> > +void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm);
> > +void optee_rpc_func_cmd_get_time(struct optee_msg_arg *arg);
> > +void optee_rpc_func_cmd_wq(struct optee *optee, struct optee_msg_arg *arg);
> > +void optee_rpc_func_cmd_wait(struct optee_msg_arg *arg);
> > +void optee_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > +                                    struct optee_msg_arg *arg);
> > +void optee_rpc_supp_cmd(struct tee_context *ctx, struct optee *optee,
> > +                       struct optee_msg_arg *arg);
> >
> >  /*
> >   * Small helpers
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index 39562fb6841e..e99e353b3f29 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -6,12 +6,10 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> >  #include <linux/delay.h>
> > -#include <linux/device.h>
> >  #include <linux/i2c.h>
> >  #include <linux/slab.h>
> >  #include <linux/tee_drv.h>
> >  #include "optee_private.h"
> > -#include "optee_smc.h"
> >  #include "optee_rpc_cmd.h"
> >
> >  struct wq_entry {
> > @@ -31,7 +29,7 @@ void optee_wait_queue_exit(struct optee_wait_queue *priv)
> >         mutex_destroy(&priv->mu);
> >  }
> >
> > -static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> > +void optee_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> >  {
> >         struct timespec64 ts;
> >
> > @@ -52,8 +50,8 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> >  }
> >
> >  #if IS_REACHABLE(CONFIG_I2C)
> > -static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > -                                            struct optee_msg_arg *arg)
> > +void optee_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > +                                    struct optee_msg_arg *arg)
> >  {
> >         struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct tee_param *params;
> > @@ -139,8 +137,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> >         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> >  }
> >  #else
> > -static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > -                                            struct optee_msg_arg *arg)
> > +void optee_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > +                                    struct optee_msg_arg *arg)
> >  {
> >         arg->ret = TEEC_ERROR_NOT_SUPPORTED;
> >  }
> > @@ -188,8 +186,7 @@ static void wq_wakeup(struct optee_wait_queue *wq, u32 key)
> >                 complete(&w->c);
> >  }
> >
> > -static void handle_rpc_func_cmd_wq(struct optee *optee,
> > -                                  struct optee_msg_arg *arg)
> > +void optee_rpc_func_cmd_wq(struct optee *optee, struct optee_msg_arg *arg)
> >  {
> >         if (arg->num_params != 1)
> >                 goto bad;
> > @@ -215,7 +212,7 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
> >         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> >  }
> >
> > -static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
> > +void optee_rpc_func_cmd_wait(struct optee_msg_arg *arg)
> >  {
> >         u32 msec_to_wait;
> >
> > @@ -237,8 +234,8 @@ static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
> >         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> >  }
> >
> > -static void handle_rpc_supp_cmd(struct tee_context *ctx, struct optee *optee,
> > -                               struct optee_msg_arg *arg)
> > +void optee_rpc_supp_cmd(struct tee_context *ctx, struct optee *optee,
> > +                       struct optee_msg_arg *arg)
> >  {
> >         struct tee_param *params;
> >
> > @@ -266,7 +263,7 @@ static void handle_rpc_supp_cmd(struct tee_context *ctx, struct optee *optee,
> >         kfree(params);
> >  }
> >
> > -static struct tee_shm *cmd_alloc_suppl(struct tee_context *ctx, size_t sz)
> > +struct tee_shm *optee_rpc_cmd_alloc_suppl(struct tee_context *ctx, size_t sz)
> >  {
> >         u32 ret;
> >         struct tee_param param;
> > @@ -289,103 +286,7 @@ static struct tee_shm *cmd_alloc_suppl(struct tee_context *ctx, size_t sz)
> >         return shm;
> >  }
> >
> > -static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> > -                                         struct optee_msg_arg *arg,
> > -                                         struct optee_call_ctx *call_ctx)
> > -{
> > -       phys_addr_t pa;
> > -       struct tee_shm *shm;
> > -       size_t sz;
> > -       size_t n;
> > -
> > -       arg->ret_origin = TEEC_ORIGIN_COMMS;
> > -
> > -       if (!arg->num_params ||
> > -           arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_INPUT) {
> > -               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > -               return;
> > -       }
> > -
> > -       for (n = 1; n < arg->num_params; n++) {
> > -               if (arg->params[n].attr != OPTEE_MSG_ATTR_TYPE_NONE) {
> > -                       arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > -                       return;
> > -               }
> > -       }
> > -
> > -       sz = arg->params[0].u.value.b;
> > -       switch (arg->params[0].u.value.a) {
> > -       case OPTEE_RPC_SHM_TYPE_APPL:
> > -               shm = cmd_alloc_suppl(ctx, sz);
> > -               break;
> > -       case OPTEE_RPC_SHM_TYPE_KERNEL:
> > -               shm = tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED);
> > -               break;
> > -       default:
> > -               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > -               return;
> > -       }
> > -
> > -       if (IS_ERR(shm)) {
> > -               arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> > -               return;
> > -       }
> > -
> > -       if (tee_shm_get_pa(shm, 0, &pa)) {
> > -               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > -               goto bad;
> > -       }
> > -
> > -       sz = tee_shm_get_size(shm);
> > -
> > -       if (tee_shm_is_registered(shm)) {
> > -               struct page **pages;
> > -               u64 *pages_list;
> > -               size_t page_num;
> > -
> > -               pages = tee_shm_get_pages(shm, &page_num);
> > -               if (!pages || !page_num) {
> > -                       arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> > -                       goto bad;
> > -               }
> > -
> > -               pages_list = optee_allocate_pages_list(page_num);
> > -               if (!pages_list) {
> > -                       arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> > -                       goto bad;
> > -               }
> > -
> > -               call_ctx->pages_list = pages_list;
> > -               call_ctx->num_entries = page_num;
> > -
> > -               arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
> > -                                     OPTEE_MSG_ATTR_NONCONTIG;
> > -               /*
> > -                * In the least bits of u.tmem.buf_ptr we store buffer offset
> > -                * from 4k page, as described in OP-TEE ABI.
> > -                */
> > -               arg->params[0].u.tmem.buf_ptr = virt_to_phys(pages_list) |
> > -                       (tee_shm_get_page_offset(shm) &
> > -                        (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> > -               arg->params[0].u.tmem.size = tee_shm_get_size(shm);
> > -               arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
> > -
> > -               optee_fill_pages_list(pages_list, pages, page_num,
> > -                                     tee_shm_get_page_offset(shm));
> > -       } else {
> > -               arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
> > -               arg->params[0].u.tmem.buf_ptr = pa;
> > -               arg->params[0].u.tmem.size = sz;
> > -               arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
> > -       }
> > -
> > -       arg->ret = TEEC_SUCCESS;
> > -       return;
> > -bad:
> > -       tee_shm_free(shm);
> > -}
> > -
> > -static void cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
> > +void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
> >  {
> >         struct tee_param param;
> >
> > @@ -409,137 +310,3 @@ static void cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
> >
> >         optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
> >  }
> > -
> > -static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
> > -                                        struct optee_msg_arg *arg)
> > -{
> > -       struct tee_shm *shm;
> > -
> > -       arg->ret_origin = TEEC_ORIGIN_COMMS;
> > -
> > -       if (arg->num_params != 1 ||
> > -           arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_INPUT) {
> > -               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > -               return;
> > -       }
> > -
> > -       shm = (struct tee_shm *)(unsigned long)arg->params[0].u.value.b;
> > -       switch (arg->params[0].u.value.a) {
> > -       case OPTEE_RPC_SHM_TYPE_APPL:
> > -               cmd_free_suppl(ctx, shm);
> > -               break;
> > -       case OPTEE_RPC_SHM_TYPE_KERNEL:
> > -               tee_shm_free(shm);
> > -               break;
> > -       default:
> > -               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > -       }
> > -       arg->ret = TEEC_SUCCESS;
> > -}
> > -
> > -static void free_pages_list(struct optee_call_ctx *call_ctx)
> > -{
> > -       if (call_ctx->pages_list) {
> > -               optee_free_pages_list(call_ctx->pages_list,
> > -                                     call_ctx->num_entries);
> > -               call_ctx->pages_list = NULL;
> > -               call_ctx->num_entries = 0;
> > -       }
> > -}
> > -
> > -void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx)
> > -{
> > -       free_pages_list(call_ctx);
> > -}
> > -
> > -static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> > -                               struct tee_shm *shm,
> > -                               struct optee_call_ctx *call_ctx)
> > -{
> > -       struct optee_msg_arg *arg;
> > -
> > -       arg = tee_shm_get_va(shm, 0);
> > -       if (IS_ERR(arg)) {
> > -               pr_err("%s: tee_shm_get_va %p failed\n", __func__, shm);
> > -               return;
> > -       }
> > -
> > -       switch (arg->cmd) {
> > -       case OPTEE_RPC_CMD_GET_TIME:
> > -               handle_rpc_func_cmd_get_time(arg);
> > -               break;
> > -       case OPTEE_RPC_CMD_WAIT_QUEUE:
> > -               handle_rpc_func_cmd_wq(optee, arg);
> > -               break;
> > -       case OPTEE_RPC_CMD_SUSPEND:
> > -               handle_rpc_func_cmd_wait(arg);
> > -               break;
> > -       case OPTEE_RPC_CMD_SHM_ALLOC:
> > -               free_pages_list(call_ctx);
> > -               handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
> > -               break;
> > -       case OPTEE_RPC_CMD_SHM_FREE:
> > -               handle_rpc_func_cmd_shm_free(ctx, arg);
> > -               break;
> > -       case OPTEE_RPC_CMD_I2C_TRANSFER:
> > -               handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> > -               break;
> > -       default:
> > -               handle_rpc_supp_cmd(ctx, optee, arg);
> > -       }
> > -}
> > -
> > -/**
> > - * optee_handle_rpc() - handle RPC from secure world
> > - * @ctx:       context doing the RPC
> > - * @param:     value of registers for the RPC
> > - * @call_ctx:  call context. Preserved during one OP-TEE invocation
> > - *
> > - * Result of RPC is written back into @param.
> > - */
> > -void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> > -                     struct optee_call_ctx *call_ctx)
> > -{
> > -       struct tee_device *teedev = ctx->teedev;
> > -       struct optee *optee = tee_get_drvdata(teedev);
> > -       struct tee_shm *shm;
> > -       phys_addr_t pa;
> > -
> > -       switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> > -       case OPTEE_SMC_RPC_FUNC_ALLOC:
> > -               shm = tee_shm_alloc(ctx, param->a1, TEE_SHM_MAPPED);
> > -               if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
> > -                       reg_pair_from_64(&param->a1, &param->a2, pa);
> > -                       reg_pair_from_64(&param->a4, &param->a5,
> > -                                        (unsigned long)shm);
> > -               } else {
> > -                       param->a1 = 0;
> > -                       param->a2 = 0;
> > -                       param->a4 = 0;
> > -                       param->a5 = 0;
> > -               }
> > -               break;
> > -       case OPTEE_SMC_RPC_FUNC_FREE:
> > -               shm = reg_pair_to_ptr(param->a1, param->a2);
> > -               tee_shm_free(shm);
> > -               break;
> > -       case OPTEE_SMC_RPC_FUNC_FOREIGN_INTR:
> > -               /*
> > -                * A foreign interrupt was raised while secure world was
> > -                * executing, since they are handled in Linux a dummy RPC is
> > -                * performed to let Linux take the interrupt through the normal
> > -                * vector.
> > -                */
> > -               break;
> > -       case OPTEE_SMC_RPC_FUNC_CMD:
> > -               shm = reg_pair_to_ptr(param->a1, param->a2);
> > -               handle_rpc_func_cmd(ctx, optee, shm, call_ctx);
> > -               break;
> > -       default:
> > -               pr_warn("Unknown RPC func 0x%x\n",
> > -                       (u32)OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0));
> > -               break;
> > -       }
> > -
> > -       param->a0 = OPTEE_SMC_CALL_RETURN_FROM_RPC;
> > -}
> 
> Isn't it possible to keep this RPC handling as part of common code
> only rather than ABI specific as otherwise for every new RPC command
> handling support we need to maintain a sync for both SMC and FF-A ABI?
> Given we should be able to create new ABI specific callbacks for this
> as well eg. for managing shared memory etc.

Good point, the two functions handle_rpc_func_cmd() and
handle_ffa_rpc_func_cmd() are almost identical. If those could be
replaced with a comon function this problem would be taken care of.

What happens in optee_handle_rpc() before the call to
handle_rpc_func_cmd() is another thing though. That processing is purely
SMC ABI specific with no common code at all.

I'll fix this for the v4 patch set.

Thanks,
Jens
