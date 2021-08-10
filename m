Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDE3E45FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhHINAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:00:06 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:48216
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233614AbhHIM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:59:59 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 64C3A4030A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628513974;
        bh=mla47bH2XlgsY9xb0/RbGlrhtAWBEInMxJuEarjH4jk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=CTtDhpTW4NomweVopcnNqKAimEaqO31EfDDygLiiUaKBlCmDvdKxhBtwB/GuXWySr
         F4caHA2Q+PPbKhR7FCmnDlE4P6wWF+DIygQ+MDnnDklNqPjmBt/ckbo8r3mLqDJce1
         FPbduoaDWecZMOuKTYbnBKxtlodXBl3Y0iWCqQ1Jw8jnAw5sPrv5qA1HASJLDf6bnJ
         +k6JaJI+pmW0MlOZMr2vSLzSKVhdaIi1lNsIp+X5hy+PWe8FQsiH+T0cQ5TuMOAuTi
         ouRBr14Zi0x/Ap/zfoZIL33hyyZvB/wcBhgVEpDYdYpQmHArTlxAYQgjx5Dd5dzztm
         rZmWFto+XKmNg==
Received: by mail-oo1-f72.google.com with SMTP id v3-20020a4ae0430000b029028735f9d900so2967186oos.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 05:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mla47bH2XlgsY9xb0/RbGlrhtAWBEInMxJuEarjH4jk=;
        b=KUSDYfQwmbJdN8+ze0z3KRSZkBv0OSOSyVrQ57zKiicUcXpNdZRpmC5x0rbD0xCM1/
         1WOlJunMaKcPmmtZkNFyvDM0iwmU8ATAm2UptZ+Bkwh0W14qld3vVc2/s8NPyiwgDIlc
         z1l+93bc84HvyfQ4JLLvTNqBIXkOXZiNmVEzGufFSWWIBp25+UD5NINeqdPXmxueSN9N
         kr998p/Seu0HPHfD78CFXDY+jhDog8BKvJQJibsEJehD9yZxcSdf31UXOE2cKLVDYc4e
         iGIyfbArNZgKqV26lp+CnI74ulk3HUJKCc+oaVOML/uAgMNjhj7KrxSuUexVcpPc03pM
         MSTw==
X-Gm-Message-State: AOAM533EZjiv99hgyufecT/+8NdNntjMA4qZdLhCrHbui2jO46aoZjwF
        HOjNAbf6EC2FePtlSdmhHK8rVSyE8c1xtw15gHdR5GSRs/2v/kH6JjCwID3bhJwuUffF2F2YrD+
        OCRHNOhpNDqk+cyZ+KN90utZAboiDugdWD1GOqRNJHAYWOevLgEKAx9nTGw==
X-Received: by 2002:aca:4e94:: with SMTP id c142mr12612604oib.177.1628513973254;
        Mon, 09 Aug 2021 05:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8wTR6iW/6M137oiAbbAQuYfhW5tbwxIiwM5nGpGeNFDYonikn6VDu2dNMD52R9RIYA2lzQE9VHTz3LCBAGFA=
X-Received: by 2002:aca:4e94:: with SMTP id c142mr12612591oib.177.1628513972997;
 Mon, 09 Aug 2021 05:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210804151325.86600-1-chris.chiu@canonical.com>
 <26f85a9f-552d-8420-0010-f5cda70d3a00@hqv.ch> <87o8aabvpj.fsf@codeaurora.org>
In-Reply-To: <87o8aabvpj.fsf@codeaurora.org>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Mon, 9 Aug 2021 20:59:22 +0800
Message-ID: <CABTNMG1tZNAZ1FusLjv6+dw9X=nMKYpYnSgNMn9cTxVY-EH6Ug@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: Fix the handling of TX A-MPDU aggregation
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Reto Schneider <rs@hqv.ch>, code@reto-schneider.ch,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        jes.sorensen@gmail.com, davem@davemloft.net, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 8:32 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Reto Schneider <rs@hqv.ch> writes:
>
> > On 8/4/21 17:13, chris.chiu@canonical.com wrote:
> >> The TX A-MPDU aggregation is not handled in the driver since the
> >> ieee80211_start_tx_ba_session has never been started properly.
> >> Start and stop the TX BA session by tracking the TX aggregation
> >> status of each TID. Fix the ampdu_action and the tx descriptor
> >> accordingly with the given TID.
> >
> > I'd like to test this but I am not sure what to look for (before and
> > after applying the patch).
>
> Thanks, testing feedback is always very much appreciated.
>
> > What should I look for when looking at the (sniffed) Wireshark traces?
>

If you are able to verify the difference by the air capture, please
refer to https://imgur.com/a/jcFQTc8. You should see more than 1
packet aggregated and sent from your wifi adapter's mac address, and
get the block ack response from the Access Point (also shown in the
image). If TX aggregation is not enabled, you will only see 1 tx
packet from your wifi, and get an ack right after from the AP.

Please also help test if there's any possible regression. Thanks so much.

Chris

> From my (maintainer) point of view most important is that there are no
> regressions visible to users, for example no data stalls, crashes or
> anything like that.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
