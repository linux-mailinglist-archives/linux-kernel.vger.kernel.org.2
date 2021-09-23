Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E59416560
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbhIWSvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbhIWSvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:51:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EDDC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:50:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so29951589lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gGXok9C2zJwna124nPWk+7zhfwPZ1Gc6OCclICzrU9s=;
        b=tF4NIGAYXmKJ/H3ElgS0dtGh5wnxcOEkstv9geZ8CLJSG7VESZWmjZPkPRe2gtBgSu
         BeOR4O5npXiBdl+y6GEeutpjj8++GniiM3Q8bzTW72t1SQBNzMgklig3FUx+Ps4q6WOO
         ONZExqJAj9rCHQDCreTVWxyF5/YupkU7KE9FasMcQSDR7ibIDieIL4wEx5EmUZSoqSG7
         rgnRL5dsU0+dLVLIG600iulp2QytIf1RRaRyp8qdx0AcQm8eQ+eftf/zqDakgs6kve4u
         IN6+h9A1q3Yklm9Edt7XyiuBR8MN2dHG8HGeGg3SuuCh60zK13BUiLeF0HEho43lciHJ
         5dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gGXok9C2zJwna124nPWk+7zhfwPZ1Gc6OCclICzrU9s=;
        b=hOVZWdPW3/ep+QqXQiW8xxpQi7iufXLEOY5lnK4244sYarVAcYS05JkfX8TldwL9eh
         CDfVMS4sep10e4h5dZ9EDYpOHlo67RXXZKa79dlhmokL4HE5nza5jE5wTYwuQU8iErUA
         4DdgX56xIZ5V7SDhqgy4ulepP1wucOglnNcSi9Etdo/o49uZhqQy7J2M4KKRlTHP7jIj
         xqS0CI8MQR2D0fSwRhK0AcUTlz31ZfdaxEAQKro8ub/WB8SL67PuejDS8jFhrq0UBT18
         3sL7P+XHiqbcEkkCHm9fk1lJcIfca826rWGBMMvLGFygUZCaXrlb+F8s9P1+B2nd4n8g
         Zwkg==
X-Gm-Message-State: AOAM53225KO85F1+eMCRNaRTstHLQel2av14+etrclgs3RqPHtSSQGAD
        GNGo535SjEedXzgRpUgwREwmQnk+iH6R60+mvivzLg==
X-Google-Smtp-Source: ABdhPJz/3jM+HCenFQ1gKxUxySNubtYcaPRo7nshJex5Hy+YMoHfq+kEtsAKYVRqCqeAyDXzSo+nzfhy17UjRv6dItM=
X-Received: by 2002:a2e:85c2:: with SMTP id h2mr6940282ljj.367.1632423012098;
 Thu, 23 Sep 2021 11:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <af8f8b8674ba4fcc9a781019e4aeb72c@hyperstone.com>
In-Reply-To: <af8f8b8674ba4fcc9a781019e4aeb72c@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:49:35 +0200
Message-ID: <CAPDyKFqD=KKgSC1PQz_RVm=sGMWtdFsaHSHDiKDxMKajbkszMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Dont wait for DRTO on Write RSP error
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sept 2021 at 07:59, Christian L=C3=B6hle <CLoehle@hyperstone.com=
> wrote:
>
> Only wait for DRTO on reads, otherwise the driver hangs.
>
> The driver prevents sending CMD12 on response errors like CRCs.
> According to the comment this is because some cards have problems
> with this during the UHS tuning sequence.
> Unfortunately this workaround currently also applies for any command
> with data.
> On reads this will set the drto timer which then triggers after a while.
> On writes this will not set any timer and the tasklet will not be
> scheduled again.
> I cannot attest for the UHS workarounds need, but even if so, it should
> at most apply to reads.
> I have observed many hangs when CMD25 response contained a CRC error.
> This patch fixes this without touching the actual UHS tuning workaround.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied for next and by adding a stable tag, thanks!

If you don't think we need the stable tag, please tell me.

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..22cf13dc799b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2081,7 +2081,8 @@ static void dw_mci_tasklet_func(struct tasklet_stru=
ct *t)
>                                  * delayed. Allowing the transfer to take=
 place
>                                  * avoids races and keeps things simple.
>                                  */
> -                               if (err !=3D -ETIMEDOUT) {
> +                               if (err !=3D -ETIMEDOUT &&
> +                                   host->dir_status =3D=3D DW_MCI_RECV_S=
TATUS) {
>                                         state =3D STATE_SENDING_DATA;
>                                         continue;
>                                 }
> --
> 2.32.0
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
