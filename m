Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0D32A88F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351817AbhCBRt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578417AbhCBPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:16:08 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD86C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:08:03 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h9so5082191qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DsSBlNf4EXaAwJmAP2RXqC/NeSvnZ6EawMkhhwwqhy8=;
        b=Lheh9tG6wk4rjSd4mQvAVKVJXQvm46sLRQGsb12SHoEeMRycT/oCP2CeGYfF5NG433
         ItW3m28QEdPazBHKU7jA0bi1YGTtXUn0+6ZoFcj12M7AZ7CjNDusEBFV03ziE5Fuq1mH
         6rgnMI2Ax+wSuDhTdSqpI+esMRwKyU0SHFFSecI1r0+3ePrOAnUzVHXu/DyMtt1PeiKf
         elgA3/M2Lj5FtPKuRJUXo9+YEjMMyHM6U7lAR4u4JTcRTEyLjxTLvW6PLF1GF1u5Eg0P
         CogEFVoXCNljGeWnmNlqV7gPt9Ec7jmlEwVLRDFqxRPLORwgijig5orzD/rb7yqVzkJc
         ZoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DsSBlNf4EXaAwJmAP2RXqC/NeSvnZ6EawMkhhwwqhy8=;
        b=ZuS2aN2MbliU5uXWWZ5E0rfPcRFOnB7Dd9dCSS9+p/L0mR5VGW/KJXJObduH1Q0xyH
         2r3OjXPVXE1nnhJkyki1Ju5YwHda9MQXacN/5OLElit+UxKAVzveH5vlu3Fkq9CWUBwX
         bpFQZztygQd2+Qe/XsCsgfV8Sai260Pfa7EQ7QbIVHBl11EvVvBPkE+/tcRA0sA+TysR
         VLat9uiEgjMdwn9/VGm3aVZqw4/y+vXY4Xvj1tzn4n/YeTEMmAZJVlE+WZpqNT7Gsfrp
         a/Cz25u9fRe9fYyNe1NMNq/4CEihVkNZsIAsvYTlLogGZ+32106o3MMeh35IUL9Xn/ws
         3qjg==
X-Gm-Message-State: AOAM5326OItgl5RtwaCbIsuxjTRm5tu6IA5vGGkf77zZjsHnYv/URXfd
        6Mkvqo7ATsiCVaJnnCBKG4gKFh3FbbRJpdXf3Ag=
X-Google-Smtp-Source: ABdhPJzxO2V13EOB0iX0WHoKmHUMqf+dJ194FHJSKu6TFN+stBrABF9cngcJoq068AMNbnrQhJLxU4PeUGGhc4JAsn8=
X-Received: by 2002:ac8:6683:: with SMTP id d3mr18451797qtp.228.1614697682144;
 Tue, 02 Mar 2021 07:08:02 -0800 (PST)
MIME-Version: 1.0
References: <CANgQ54cmG4mCx42i1ErXMJpv=2OmOGjjEgv=8oy90CpKcwkpZg@mail.gmail.com>
In-Reply-To: <CANgQ54cmG4mCx42i1ErXMJpv=2OmOGjjEgv=8oy90CpKcwkpZg@mail.gmail.com>
From:   =?UTF-8?B?6YKx5ZCN56Kp?= <ccchiu77@gmail.com>
Date:   Tue, 2 Mar 2021 23:07:50 +0800
Message-ID: <CANgQ54fSYJDoyoE-9064cyHybMN88Gxt3ZmsfWbVaDVO_sM6bw@mail.gmail.com>
Subject: Re: Questions for TX power get/set implementation of realtek WiFi
To:     pkshih@realtek.com, tehuang@realtek.com, Larry.Finger@lwfinger.net
Cc:     Reto Schneider <reto.schneider@husqvarnagroup.com>,
        kvalo@codeaurora.org, kuba@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E9=82=B1=E5=90=8D=E7=A2=A9 <ccchiu77@gmail.com> =E6=96=BC 2021=E5=B9=B43=
=E6=9C=882=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:21=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi guys,
>     I'm planning to implement the get_txpower hook function of the
> struct ieee80211_ops and handle the IEEE80211_CONF_CHANGE_POWER for
> rtl8xxxu driver. So that users can get the information of the current
> tx power limit and set a new limit value with iw commands.
>
>     I found there's phy_txpwr_idx_to_dbm() of each driver in
> realtek/rtlwifi to translate the tx power index parsed from efuse to
> tx power level in dBm. Does the power level translated represent the
> current tx power limit in dBm? In my RTL8188CUS module, the power
> index of CCK/OFDM from efuse for each channel is basically 36/38, thus
> the translated txpower level is 11dBm. Is this the expected value for
> the default txpower limit value? Or do I need some other formula to
> compute?
>
>     And for the handler of IEEE80211_CONF_CHANGE_POWER, can I
> translate the hw->conf.power_level with the phy_dbm_to_txpwr_idx
> functions I found in some rtlwifi family drivers, then directly set
> the txpower index with phy_set_txpower_index functions which write
> power index to bbreg for different rates (CCK and OFDM)? Are there
> some invalid values I should take care of because the TCP RX
> performance seems to be extremely low when I write the power index
> value translated from 20dBm to bbreg. Any suggestions for what I
> should handle before writing the bbreg?
>
> Chris

Sorry for confusion. I'm removing and correcting the invalid mail address h=
ere.
