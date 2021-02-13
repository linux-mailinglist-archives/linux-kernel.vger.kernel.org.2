Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C7131AAF0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 11:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBMKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 05:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:55:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744A3C061756
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 02:55:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g10so2577101wrx.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 02:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7aJCQPOAWhA7x4o25lcJFhvX0SrgHfv80XtgRDoDP4=;
        b=wLgGZeVFTkNo/KYwPBF7sQ4JU6KMzh3rUFRnZsXataO9rNbkboX3IS3ML/eQ3sdn9c
         3BpDHqu4bJ43peaZEjoAJX/QKxsxxt3B0CNeC0I+FKW4j83W6qBpTxayn+iLs0eZgjaR
         cWuQvJKxyoHo+UdxxmhX+zCTmyVI6Ju1eH+fVbfDnBn5lbxQUlXD8tzUYOkLgvr2zOP5
         InwqsN56moapHKC8xretWr6F5p3WWlAe4bNsrvm3CniXUTUtwj2PbqIx0NbRGQwjIIA2
         gSxeq3rzdiW7AkjZn5xE0V+Dk5RWnc7hL2RxN1WXIl4k7vSgqSE99Ama8srX7MQJXgd/
         jXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7aJCQPOAWhA7x4o25lcJFhvX0SrgHfv80XtgRDoDP4=;
        b=H174kgXoyB2UFU5jqU6tbVZcmTHEBnD3DKRHAYxhrLDpKCg202RDgOO+mfCqDhc8+q
         zwkdT18+tUcb+hCipCslVq56muSFK8Pp9zzVpa7rWgkI0ZNWpVfUI+ZINx4gl28KEZYQ
         d1Umxj+MO08yzd9W1fiNTKBZkwYW3c2S/rjZPijy5k0CrRnOVPPHK616ULoM/thhQB0m
         EVw4PRZcJStQa1vPsXEhJX4r+uqGoetILUSdQw+Usr++lgkazoriZDH3n4a+7TxVaa+G
         sPEO/CpGssprwE6MjB8pJoWtdbflwbbGjxl1Og+FztmDNR3CEYGc+Zv1CRunkQ/UEJXH
         foBg==
X-Gm-Message-State: AOAM5319yyYRKhdaZRaqMQZMgvhpCSm+CGaTcPDTFaMbKgD2ROiWKqFS
        Ilm0yzlonlGUiUnhqmvYciEPax/gHUzvWnmeSjFtYDCmnhD7yA==
X-Google-Smtp-Source: ABdhPJx6AtGx/GgpqQgbBTpHd04etQqgxM8y1ZKKYsczFDKKXWnhl/Vn66Xlhx3En73obdX4RK9nbVYmFwVErzpnIcc=
X-Received: by 2002:adf:e884:: with SMTP id d4mr7991020wrm.275.1613213704109;
 Sat, 13 Feb 2021 02:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20210212172336.20550-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20210212172336.20550-1-saiprakash.ranjan@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sat, 13 Feb 2021 10:54:53 +0000
Message-ID: <CAJ9a7VgDxgVUhgrcZc7jX3psWrxWoqHOJ+O36eQf7+-MjVOVeQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: Add ETM PIDs for Cortex-A55 and Cortex-A78
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

This patch does not apply to coresight/next - possibly because the PID
for A55 has been added in an earlier patch ( [b8336ad947e19 ]
coresight: etm4x: add AMBA id for Cortex-A55 and Cortex-A75).

Regards

Mike



On Fri, 12 Feb 2021 at 17:23, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add ETM PIDs for Cortex-A55 and Cortex-A78 to the list of
> supported ETMs.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index b20b6ff17cf6..193233792ab5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1713,7 +1713,9 @@ static const struct amba_id etm4_ids[] = {
>         CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
>         CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
>         CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
> +       CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
>         CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
> +       CS_AMBA_UCI_ID(0x000bbd41, uci_id_etm4),/* Cortex-A78 */
>         CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
>         CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
>         CS_AMBA_UCI_ID(0x000bb802, uci_id_etm4),/* Qualcomm Kryo 385 Cortex-A55 */
>
> base-commit: 1efbcec2ef8c037f1e801c76e4b9434ee2400be7
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
