Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D503449A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbhKHRDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:03:18 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:47306 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhKHRDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:03:17 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:42358)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mk80V-00Dm7O-2T; Mon, 08 Nov 2021 10:00:31 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53774 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mk80U-001noj-5H; Mon, 08 Nov 2021 10:00:30 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20211105075119.2327190-1-arnd@kernel.org>
Date:   Mon, 08 Nov 2021 11:00:03 -0600
In-Reply-To: <20211105075119.2327190-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Fri, 5 Nov 2021 08:51:12 +0100")
Message-ID: <87k0hipoq4.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mk80U-001noj-5H;;;mid=<87k0hipoq4.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xWBTX/qOTO5dbjayArZR1W6WXfYyeGgc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMGappySubj_01,XMGappySubj_02,
        XMSubLong,XM_B_Investor autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_B_Investor BODY: Commonly used business phishing phrases
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.0 XMGappySubj_02 Gappier still
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Arnd Bergmann <arnd@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 356 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (1.1%), b_tie_ro: 2.5 (0.7%), parse: 0.64
        (0.2%), extract_message_metadata: 8 (2.3%), get_uri_detail_list: 1.13
        (0.3%), tests_pri_-1000: 11 (3.1%), tests_pri_-950: 1.01 (0.3%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 107 (30.1%), check_bayes:
        105 (29.5%), b_tokenize: 5 (1.5%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 1.49 (0.4%), b_tok_touch_all: 89 (25.0%), b_finish: 0.79
        (0.2%), tests_pri_0: 214 (60.0%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 1.72 (0.5%), poll_dns_idle: 0.40 (0.1%),
        tests_pri_10: 1.69 (0.5%), tests_pri_500: 5 (1.5%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] soc: ti: fix wkup_m3_rproc_boot_thread return type
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The wkup_m3_rproc_boot_thread() function uses a nonstandard prototype,
> which broke after Eric's recent cleanup:
>
> drivers/soc/ti/wkup_m3_ipc.c: In function 'wkup_m3_rproc_boot_thread':
> drivers/soc/ti/wkup_m3_ipc.c:429:16: error: 'return' with a value, in function returning void [-Werror=return-type]
>   429 |         return 0;
>       |                ^
> drivers/soc/ti/wkup_m3_ipc.c:416:13: note: declared here
>   416 | static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Change it to the normal prototype as it should have been from the
> start.

Thanks for catching this.  I will add it to my tree.

Eric

>
> Fixes: 111e70490d2a ("exit/kthread: Have kernel threads return instead of calling do_exit")
> Fixes: cdd5de500b2c ("soc: ti: Add wkup_m3_ipc driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/ti/wkup_m3_ipc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
> index 0733443a2631..72386bd393fe 100644
> --- a/drivers/soc/ti/wkup_m3_ipc.c
> +++ b/drivers/soc/ti/wkup_m3_ipc.c
> @@ -413,8 +413,9 @@ void wkup_m3_ipc_put(struct wkup_m3_ipc *m3_ipc)
>  }
>  EXPORT_SYMBOL_GPL(wkup_m3_ipc_put);
>  
> -static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
> +static int wkup_m3_rproc_boot_thread(void *arg)
>  {
> +	struct wkup_m3_ipc *m3_ipc = arg;
>  	struct device *dev = m3_ipc->dev;
>  	int ret;
>  
> @@ -500,7 +501,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
>  	 * can boot the wkup_m3 as soon as it's ready without holding
>  	 * up kernel boot
>  	 */
> -	task = kthread_run((void *)wkup_m3_rproc_boot_thread, m3_ipc,
> +	task = kthread_run(wkup_m3_rproc_boot_thread, m3_ipc,
>  			   "wkup_m3_rproc_loader");
>  
>  	if (IS_ERR(task)) {
