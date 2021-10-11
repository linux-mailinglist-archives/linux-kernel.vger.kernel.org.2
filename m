Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031D842905C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhJKOH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239644AbhJKOFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:05:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39CBC61205
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633960777;
        bh=rkohdeuOCoR8kAtcJvy104JWs1ZWbGyOoO5ZB7p/tvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z1yABtDjSQoRxFvuVsZSUe83tbWD1ReVYa82Fv4Y3Dyqz+QNlcrV/t4cxQHBaShYH
         FC6KPqIpKGm7ly5XtlsDCUCaVzEI78+BvGm7VitAG9asXEsMgkkjIu+tPcWY1VT+kT
         gsYfdH3XOa7K3bQdSBxL5M5OLSb386Imi+sk4Vu+0foXYRI9PX7rDOLel1a32XVIjb
         GIzv0/qLTClHOoF2kpg8Wul4YEiPeyciB0KItTiwDKQjImwW9SBsBbz++IwWIPkZe/
         B/vCOSQWB/b0KI7/1PRT/K1czVxCZL5P7sshuJfHa5Co1fOC5bI22dZYmV1j95t3A+
         +un3SMJsvJPxg==
Received: by mail-yb1-f171.google.com with SMTP id n65so39219635ybb.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:59:37 -0700 (PDT)
X-Gm-Message-State: AOAM533zgcKmpRgN2WyPGT4PnVPswd2o/9vO3KB9N7AEgoQK1F/XYqFU
        bTGPwX+aVkbExrz3V0hMtPk0/GxVKd8O6gO3yIw=
X-Google-Smtp-Source: ABdhPJzzZXYYC1LNYRQJmD5PzxpbgILwJ8eavXTdbpgnFgkr75pBe4IXfwcuCxKlRjnefucpox0NUkUhq+O/cHBpFmE=
X-Received: by 2002:a25:7415:: with SMTP id p21mr21636740ybc.78.1633960776263;
 Mon, 11 Oct 2021 06:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <202110111947.2oUxucXl-lkp@intel.com>
In-Reply-To: <202110111947.2oUxucXl-lkp@intel.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 11 Oct 2021 16:59:09 +0300
X-Gmail-Original-Message-ID: <CAFCwf10o1gGqxztuKy9jVeed9FCjE=iE_mCu5AeD6iOWiNFt_A@mail.gmail.com>
Message-ID: <CAFCwf10o1gGqxztuKy9jVeed9FCjE=iE_mCu5AeD6iOWiNFt_A@mail.gmail.com>
Subject: Re: [kbuild] [ogabbay:habanalabs-next 17/19] drivers/misc/habanalabs/common/command_submission.c:2421
 hl_cs_poll_fences() error: we previously assumed 'fence' could be null (see
 line 2402)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Dani Liberman <dliberman@habana.ai>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 2:48 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git  habanalabs-next
> head:   41548e6097f0e2673e99c18aa74c9bbba341c9ba
> commit: 2819e6243c5cdf6619cdaddaf117076a043d7bb2 [17/19] habanalabs: fix NULL pointer dereference
> config: x86_64-randconfig-m001-20211011 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/misc/habanalabs/common/command_submission.c:2421 hl_cs_poll_fences() error: we previously assumed 'fence' could be null (see line 2402)
>
> vim +/fence +2421 drivers/misc/habanalabs/common/command_submission.c
>
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2346  static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2347  {
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2348       struct hl_fence **fence_ptr = mcs_data->fence_arr;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2349       struct hl_device *hdev = mcs_data->ctx->hdev;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2350       int i, rc, arr_len = mcs_data->arr_len;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2351       u64 *seq_arr = mcs_data->seq_arr;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2352       ktime_t max_ktime, first_cs_time;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2353       enum hl_cs_wait_status status;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2354
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2355       memset(fence_ptr, 0, arr_len * sizeof(*fence_ptr));
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2356
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2357       /* get all fences under the same lock */
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2358       rc = hl_ctx_get_fences(mcs_data->ctx, seq_arr, fence_ptr, arr_len);
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2359       if (rc)
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2360               return rc;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2361
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2362       /*
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2363        * set to maximum time to verify timestamp is valid: if at the end
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2364        * this value is maintained- no timestamp was updated
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2365        */
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2366       max_ktime = ktime_set(KTIME_SEC_MAX, 0);
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2367       first_cs_time = max_ktime;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2368
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2369       for (i = 0; i < arr_len; i++, fence_ptr++) {
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2370               struct hl_fence *fence = *fence_ptr;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2371
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2372               /*
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2373                * function won't sleep as it is called with timeout 0 (i.e.
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2374                * poll the fence)
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2375                */
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2376               rc = hl_wait_for_fence(mcs_data->ctx, seq_arr[i], fence,
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2377                                               &status, 0, NULL);
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2378               if (rc) {
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2379                       dev_err(hdev->dev,
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2380                               "wait_for_fence error :%d for CS seq %llu\n",
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2381                                                               rc, seq_arr[i]);
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2382                       break;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2383               }
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2384
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2385               /*
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2386                * It is possible to get an old sequence numbers from user
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2387                * which related to already completed CSs and their fences
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2388                * already gone. In this case, no need to consider its QID for
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2389                * mcs completion.
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2390                */
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2391               if (fence)
>                                                                                                                     ^^^^^
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2392                       mcs_data->stream_master_qid_map |=
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2393                                       fence->stream_master_qid_map;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2394
> f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2395               /*
> f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2396                * Using mcs_handling_done to avoid possibility of mcs_data
> f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2397                * returns to user indicating CS completed before it finished
> f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2398                * all of its mcs handling, to avoid race the next time the
> f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2399                * user waits for mcs.
> f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2400                */
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2401               if (status == CS_WAIT_STATUS_BUSY ||
> 2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06 @2402                               (fence && !fence->mcs_handling_done))
>                                                                                                                                  ^^^^^
> Checks for NULL
>
>
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2403                       continue;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2404
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2405               mcs_data->completion_bitmap |= BIT(i);
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2406
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2407               /*
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2408                * best effort to extract timestamp. few notes:
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2409                * - if even single fence is gone we cannot extract timestamp
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2410                *   (as fence not exist anymore)
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2411                * - for all completed CSs we take the earliest timestamp.
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2412                *   for this we have to validate that:
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2413                *       1. given timestamp was indeed set
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2414                *       2. the timestamp is earliest of all timestamps so far
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2415                */
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2416
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2417               if (status == CS_WAIT_STATUS_GONE) {
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2418                       mcs_data->update_ts = false;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2419                       mcs_data->gone_cs = true;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2420               } else if (mcs_data->update_ts &&
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14 @2421                       (ktime_compare(fence->timestamp,
>                                                                                                                                        ^^^^^^^
> Unchecked dereferences.
Hi Dan,
Thanks for the report.
I believe this is a false positive, because if the fence is NULL, then
status *must* be CS_WAIT_STATUS_GONE.
I agree the code is not well written here and you can only understand
the above if you go and look in
the code of hl_wait_for_fence().
Therefore, we will refactor the code here to make it more readable and
depend only on the status field
instead of checking if the fence pointer is NULL.

Oded


>
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2422                                               ktime_set(0, 0)) > 0) &&
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2423                       (ktime_compare(fence->timestamp, first_cs_time) < 0)) {
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2424                       first_cs_time = fence->timestamp;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2425               }
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2426       }
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2427
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2428       hl_fences_put(mcs_data->fence_arr, arr_len);
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2429
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2430       if (mcs_data->update_ts &&
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2431                       (ktime_compare(first_cs_time, max_ktime) != 0))
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2432               mcs_data->timestamp = ktime_to_ns(first_cs_time);
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2433
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2434       return rc;
> 215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2435  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
>
