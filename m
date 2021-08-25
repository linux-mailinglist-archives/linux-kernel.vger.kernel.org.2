Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC83F71A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbhHYJYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhHYJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:24:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F50C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:23:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so51475460lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mBOqCYg27C+Q3PwzWEuLJVfKyp+8yvqYMrIfXGs11Y=;
        b=Q3dBHeTYIwOwbucgFfK8d9ASkbm5rUi/+Q3HIhoDBdZRxgxwcl5DQYHiRyEw0yz+L9
         xDjG4W7m4tyF94ME495jyig90RGY9HyGZbM08EiWsZgTBht3FbFFLQyu1+sJmJvDiI/v
         YRivpud8KxHvJujh0IanKUwf29KCOXOSCUbJMqUkyF5Qbm9kAfKtUQAv8KmT02TqLwGk
         35TPQazsrUZrgUVeHOTdMST9/IaRPkqVe4OvRigevo/msDJlDTDp+GfkXFciJLzJ3D81
         D6EZxKoewbjY7Iwd6wUY37M3GdoAyQo69W2Czf6YTNlmzWRfM5cOd81PUCjHzVBd8Ln3
         Pfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mBOqCYg27C+Q3PwzWEuLJVfKyp+8yvqYMrIfXGs11Y=;
        b=FBChU2znfR2l/UjkXJuEvw53YSvGIcT7bkF+7ktrDm0g6cJXcbTyr80IASJsIS0TuT
         hE2ff8lDNrxSdyyj94PPCSfy4Xe/POuVUXeN+5rj4BLa6DFA8/Q0cztG8uRIBuoxdQWj
         Xl+s6MbFQMQyeiO+tu1G9q2GK4x5zKfLrtmlXWCdsdzYLW5kHCpSHK1Usc2f7rJTqwee
         xq6kO4Ica4Dx0nDQ1F6raLdXMPAwePxori/S6BJV5pN0Drh49136IULzGw60mZg/nrzZ
         Pr++jc1EqPSUVNNHIktdZKG/aTZuJ9QKNiBAh42w3hXGG7gEF7YMSukfyxxhfbrqXZKo
         iqCw==
X-Gm-Message-State: AOAM530Adf7etO2d690uQ3zA8zpW2TJNpTMEmO5uBJuVmzCNAu3QtdoT
        YsmSIGDeF4pwYzFO8DIBKEtI7rN5A1YW8p291Rleyw==
X-Google-Smtp-Source: ABdhPJwtIrWET1bt7B4ArznEl9kTzyGS0PiR0P8t0Ut+6kLg1OrcDqwcMQk5ozsVErbwqUuSMbO8oPb3K62k4CjlIho=
X-Received: by 2002:a19:655e:: with SMTP id c30mr4982752lfj.142.1629883396160;
 Wed, 25 Aug 2021 02:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210824191726.8296-1-nishadkamdar@gmail.com>
In-Reply-To: <20210824191726.8296-1-nishadkamdar@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Aug 2021 11:22:40 +0200
Message-ID: <CAPDyKFq0+FBpa+VrQm+Q511EPrDvK8cwhi3xFsxpbS4Opn0G8A@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: Return correct emmc response in case of
 ioctl error
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 at 21:17, Nishad Kamdar <nishadkamdar@gmail.com> wrote:
>
> When a read/write command is sent via ioctl to the kernel,
> and the command fails, the actual error response of the emmc
> is not sent to the user.
>
> IOCTL read/write tests are carried out using commands
> 17 (Single BLock Read), 24 (Single Block Write),
> 18 (Multi Block Read), 25 (Multi Block Write)
>
> The tests are carried out on a 64Gb emmc device. All of these
> tests try to access an "out of range" sector address (0x09B2FFFF).
>
> It is seen that without the patch the response received by the user
> is not OUT_OF_RANGE error (R1 response 31st bit is not set) as per
> JEDEC specification. After applying the patch proper response is seen.
> This is because the function returns without copying the response to
> the user in case of failure. This patch fixes the issue.
>
> Hence, this memcpy is required whether we get an error response or not.
> Therefor it is moved up from the current position up to immediately
> after we have called mmc_wait_for_req().
>
> The test code and the output of only the CMD17 is included in the
> commit to limit the message length.
>
> CMD17 (Test Code Snippet):
> ==========================
>         printf("Forming CMD%d\n", opt_idx);
>         /*  single block read */
>         cmd.blksz = 512;
>         cmd.blocks = 1;
>         cmd.write_flag = 0;
>         cmd.opcode = 17;
>         //cmd.arg = atoi(argv[3]);
>         cmd.arg = 0x09B2FFFF;
>         /* Expecting response R1B */
>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>
>         memset(data, 0, sizeof(__u8) * 512);
>         mmc_ioc_cmd_set_data(cmd, data);
>
>         printf("Sending CMD%d: ARG[0x%08x]\n", opt_idx, cmd.arg);
>         if(ioctl(fd, MMC_IOC_CMD, &cmd))
>                 perror("Error");
>
>         printf("\nResponse: %08x\n", cmd.response[0]);
>
> CMD17 (Output without patch):
> =============================
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 0x09B2FFF]
> Forming CMD17
> Sending CMD17: ARG[0x09b2ffff]
> Error: Connection timed out
>
> Response: 00000000
> (Incorrect response)
>
> CMD17 (Output with patch):
> ==========================
> test@test-LIVA-Z:~$ sudo ./mmc cmd_test /dev/mmcblk0 17
> [sudo] password for test:
> Entering the do_mmc_commands:Device: /dev/mmcblk0 nargs:4
> Entering the do_mmc_commands:Device: /dev/mmcblk0 options[17, 09B2FFFF]
> Forming CMD17
> Sending CMD17: ARG[0x09b2ffff]
> Error: Connection timed out
>
> Response: 80000900
> (Correct OUT_OF_ERROR response as per JEDEC specification)
>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v4:
>   - Moved the existing
>     "memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));"
>     from a couple of lines further down in the code, up to
>     immediately after we have called mmc_wait_for_req().
>   - Modified the commit message to explain this change
> Changes in v3:
>   - Shorten the commit message to include only CMD17 related
>     code and test.
> Changes in v2:
>   - Make commit message clearer by adding test cases as outputs.
>
>  drivers/mmc/core/block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 672cc505ce378..94bb8b4cd6a4e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -557,6 +557,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>                 return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
>
>         mmc_wait_for_req(card->host, &mrq);
> +       memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
>
>         if (cmd.error) {
>                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
> @@ -606,8 +607,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         if (idata->ic.postsleep_min_us)
>                 usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
>
> -       memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
> -
>         if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
>                 /*
>                  * Ensure RPMB/R1B command has completed by polling CMD13
> --
> 2.17.1
>
