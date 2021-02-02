Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8205F30BCB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhBBLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBBLMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:12:36 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09351C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 03:11:56 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v123so4043210yba.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 03:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/bHfvCMAqb1V7v7A4IFiandeTfZNu+bcanftQaRqOs=;
        b=C38eO2uux41TbI58aglk3idPPs7gQLHEvTYJmZb8yC4zQ/IwysV7nuPPPHd3anr7W5
         Okg1fS/8QhuDv2Z85twPmvBxyGaI3l7iJmOOtrAkxyswGEojsOFHtOgJ69dD9J1nbTSW
         N9FZtNLlVEYvsZAj8ECfLofgy/nUbaQdQ8owKp554KAysP9NV2Bc8wzEFrI/Ne3agsmz
         09t/mr5EAcSsAi5SFaUSSbOpCIls3rowEgQoah6ysP9RxBL0vFwAPiXDT2UwS0WsounG
         mMRRNpmAYaprRlnJ5Sgkyg4yOgL5rMJu8BHhHNGOkRAGW9YSG1/6fh2b5Ihdb2s+NsnB
         Ax3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/bHfvCMAqb1V7v7A4IFiandeTfZNu+bcanftQaRqOs=;
        b=orNjJlZ2LomiwelcI0Z/hdab/VCIbJZ+imkxI4hUcWwpVAiX/lomQ1u0bVg8ca+hw+
         ostf7e8RXqX9jf5xSmTtFMfONwj0SBmzYJbNMrRCnP5Rx3GgjdG6jE+DkhQe27muiCa4
         Vcn4jthikB32D12ETRaSy5HfKS6l7QdpIkJm/9Ecfia1bIdYah1o1DfqpSzRi2p9rw+M
         40gvW1zEqNPhb56vfg69e2tKXitbLu6cx2AG2d91R2kPMP/IEMCi13w+hI1sYJnrMrRm
         uVovChGrFL39+4kC45EetJc3pQUoMaw4eHiGJiUXh6LDT3X4LMdhv69Q9q+tgxUoME3f
         Dg6Q==
X-Gm-Message-State: AOAM531cl5cONr91ozOtGo2CxktQ4LDxRyHa2S8HvcBzXpUM0wNlWEsH
        7bQ2XTrpjvHTZahMchR3YcKRq6W4EWQWPLOlrmlr1Q==
X-Google-Smtp-Source: ABdhPJyUoRohpUuiZdZg6GMhYw0kD23x1MnP6h4YqY8QzzNrKMDZjxYkcKrbZvY8iZx3OoRsJW5EKu4EHY4mgHG524k=
X-Received: by 2002:a25:da41:: with SMTP id n62mr29665321ybf.155.1612264315156;
 Tue, 02 Feb 2021 03:11:55 -0800 (PST)
MIME-Version: 1.0
References: <1601058581-19461-1-git-send-email-amit.pundir@linaro.org>
 <20200929190817.GA968845@bogus> <20201029134017.GA807@yoga>
 <CAMi1Hd20UpNhZm6z5t5Kcy8eTABiAj7X_Gm66QnJspZWSio0Ew@mail.gmail.com>
 <20201124175146.GG185852@builder.lan> <87sg8heeta.fsf@codeaurora.org>
In-Reply-To: <87sg8heeta.fsf@codeaurora.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 2 Feb 2021 16:41:19 +0530
Message-ID: <CAMi1Hd2FN6QQzbKHooVyqQfH1NFTNLt4RwxyVXRf+5DwTc9ojg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Introduce a devicetree quirk to skip host cap QMI requests
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        Konrad Dybcio <konradybcio@gmail.com>,
        ath10k <ath10k@lists.infradead.org>,
        David S Miller <davem@davemloft.net>,
        John Stultz <john.stultz@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle,

On Mon, 7 Dec 2020 at 22:25, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> This is firmware version specific, right? There's also enum
> ath10k_fw_features which is embedded within firmware-N.bin, we could add
> a new flag there. But that means that a correct firmware-N.bin is needed
> for each firmware version, not sure if that would work out. Just
> throwing out ideas here.

Apologies for this late reply. I was out for a while.

If by that (the firmware version) you mean "QC_IMAGE_VERSION_STRING",
then that may be a bit tricky. Pocophone F1 use the same firmware
family version (WLAN.HL.2.0.XXX), used by Dragonboard 845c (which has
Wi-Fi working upstream).

Regards,
Amit Pundir

>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
