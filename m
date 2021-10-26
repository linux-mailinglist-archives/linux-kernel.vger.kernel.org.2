Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E643B5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhJZPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbhJZPnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:43:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8EC061229
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:40:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h11so8295524ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JGWO5jt5QtIvnBeSd0VahxH9KJ8Ngd7aKYQ3TRmWp4=;
        b=l2eP8kM2v64pFzuyyl8uOFKlFsPMlKgu6nnHVfMCPdQcboDCBDOmjuw0LUnrnUA68/
         Y9Du49VrgR8hzTI2lL8jYGRLZ3N/CdAj2UJa//D5Me0NsdW1XrxIUELXxar8F7tQUHFu
         T9BdjUzWCTFDoNcGquFwDDivn7fM1bRYMrOqW3QpKqpkZ9d2vepoEGz8jmRhH58Woyci
         VcW/VYfg3j+oRkS8ezSEbsIK9VqX2cRXWU9PXXZRW+x+1gfk05kp1Zi+YGHKjNhwPO42
         QZSEsV2bLE5Wf7E27EzkFUeqV07DltcwQ47yJa3z1Jz4Di36WWw96qjcs2I02GUBJTvw
         phqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JGWO5jt5QtIvnBeSd0VahxH9KJ8Ngd7aKYQ3TRmWp4=;
        b=do3Z8KxIhYtmpESJY8ENGFPrRQPI9BxgU2GdP2dWN9oWm5kUka2FWTwJ9o2F6YV1J7
         Dpe30SXEac8CEpmIhwhu44PoHOHHzAOQMxKCZUwasMxRpfbdtvczqhDICjnrQLyaDJIC
         8JPTe7VaTjkGnkEwqUT7mLQC84nZKUk5WHR/KSyuo0Jg18e4pkBomFhzhYT83ZnINzkF
         z8SxXjH/YnRjBHoSZVONtvtO9o0eTsd8rkV8NLYkRpm/srOGz5c3jQ9W1izO6bq6v9p5
         608IiEknjbeIZoZ92cecp6dStGzS8HuDaj0mQ3vQ1LkDZEeJp4aNEUP1P1BVCxarcfm5
         XejA==
X-Gm-Message-State: AOAM531z2ikLm5LCAx6VDI3EM2k9I7u47l5JxoV9NSIiMB+G97vOuCnH
        P82SkUeMttLoYs43vnneZHTDw2DycymxfSFsEmf/7g==
X-Google-Smtp-Source: ABdhPJxxOsxXey/zZUMsKaDVg3dujNtrb2v5kzU7OfyCjPJ0s85CzbTm/9BZ3RdZ4fBQvppT3W8byIBy4h5Ka655VpI=
X-Received: by 2002:a05:651c:907:: with SMTP id e7mr28394579ljq.300.1635262849171;
 Tue, 26 Oct 2021 08:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211026070812.9359-1-wenbin.mei@mediatek.com>
In-Reply-To: <20211026070812.9359-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Oct 2021 17:40:12 +0200
Message-ID: <CAPDyKFpGSrMkFg1PkRaH6zePOqH7aSbjfoCk6AhWgwGnSkoNAw@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: clear HALT state after CQE enable
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 at 09:08, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> While mmc0 enter suspend state, we need halt CQE to send legacy cmd(flush
> cache) and disable cqe, for resume back, we enable CQE and not clear HALT
> state.
> In this case MediaTek mmc host controller will keep the value for HALT
> state after CQE disable/enable flow, so the next CQE transfer after resume
> will be timeout due to CQE is in HALT state, the log as below:
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: timeout for tag 2
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: Caps:      0x100020b6 | Version:  0x00000510
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: Config:    0x00001103 | Control:  0x00000001
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: TDL base:  0xfd05f000 | TDL up32: 0x00000000
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: Doorbell:  0x8000203c | TCN:      0x00000000
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00001000
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000000
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: CRNQP:     0x00000000 | CRNQDUN:  0x00000000
> <4>.(4)[318:kworker/4:1H]mmc0: cqhci: CRNQIS:    0x00000000 | CRNQIE:   0x00000000
>
> This change check HALT state after CQE enable, if CQE is in HALT state, we
> will clear it.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Cc: stable@vger.kernel.org

Applied for fixes and by adding a fixes tag, thanks!

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index ca8329d55f43..b0d30c35c390 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -282,6 +282,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>
>         cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>
> +       if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
> +               cqhci_writel(cq_host, 0, CQHCI_CTL);
> +
>         mmc->cqe_on = true;
>
>         if (cq_host->ops->enable)
> --
> 2.25.1
>
