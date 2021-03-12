Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4485F3384E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 06:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhCLFJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 00:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhCLFIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 00:08:46 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72294C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:08:46 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id v11so1363959uao.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHOpvLhtcBHbawIEfPz5vAJeY+3oJDGose4sCS14ksM=;
        b=ji/rHHnMPcSm4WLA9naLB2j+Vp4jtFUnVlqAWZEb7g4lwsK4w50Xo8CivItnD5kt37
         c33wqWjZS8uyoKoAQGWSGJwnyF9wCNK20JXj/C8yBTDDYC8L9Nbypb8x5qt59fhwhQX7
         yX7PvrP4JZCusZRmRYRXk8z8u9QIzHh+nQWzAwhgkpQeFcbwuwpp0VESgEfh2SyMmTZx
         4JtQ/Hnq1MPahG1u+aqLi4vdRZM/E47Ihqq8NCHGLEj+jmIdhbSNrFDToO28vHWvaI3A
         TSo4lpDddfbemVh1dSj+n29yNhnmeQlmw+A+lVnJOYGSyGBFAzGWATfuS4mYPFlJO8C8
         ft2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHOpvLhtcBHbawIEfPz5vAJeY+3oJDGose4sCS14ksM=;
        b=oyQnCOZgc5Vi/+Hbdre4BziUPcA2bbchjZEvnymD1uazep5gJYk7ERpai2LV24sYYN
         UteF0JXTTGqWM5GHrrD88jLfuV03cmevtH1F115ahbcg98xrsHIwyMfCF/CUO+0oN9Hp
         nwLOrfV0WKjel9P6uKHF7Q7DW/6eViWF6WmkJYLawfacgG3Wr0PAP3PXxTxC39RldgnE
         T2F5xXyUxh3SOpLO2d2L+LpycBJVrtOzsHQ13F7aW5E5WUh9LY2+K3WzMdmZXsyUjANu
         vHKDtqJ6HDqg3ec614YAmjIspzBw94vmnA0E6XjR4vxuC0uX+d0VCCrSkcwG3mGpLCtJ
         3V2Q==
X-Gm-Message-State: AOAM530U+wrZvNfUq5x4zHpOGnL2FLm3Yk/IoBrtxNTdHEexaONSTlHT
        kw6tJ5VQkHkPKwIQLc2Sx/UZUoCqRxNeUmYeShy/jA==
X-Google-Smtp-Source: ABdhPJwihHID2NqIizK1UVSvkKIlg1hQtMOUGnX9QgjjQuWobQoLMA4beT9qvQURge0Xfa+UMUNJnIsYo+zLxN3ygF0=
X-Received: by 2002:ab0:4d6a:: with SMTP id k42mr7030498uag.69.1615525720433;
 Thu, 11 Mar 2021 21:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20210311100313.3591254-1-badhri@google.com> <20210311100313.3591254-3-badhri@google.com>
 <YEocMN1aSdDZ2dl/@kuha.fi.intel.com>
In-Reply-To: <YEocMN1aSdDZ2dl/@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 11 Mar 2021 21:08:04 -0800
Message-ID: <CAPTae5KNXK1M1L134RKj6QPr1NGv5uo-43NVZ+cM5otsxjvMOw@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb: typec: tcpci_maxim: configure charging & data paths
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 5:33 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> On Thu, Mar 11, 2021 at 02:03:12AM -0800, Badhri Jagan Sridharan wrote:
> > This change allows the driver to configure input current/voltage
> > limit for the charging path. The driver sets current_max and voltage_max
> > values of the power supply identified through chg-psy-name.
> >
> > The change also exposes the data_role and the orientation as a extcon
> > interface for configuring the USB data controller.
>
> This looks wrong to me. Why wouldn't you just register your device as
> a separate psy that supplies your charger (which is also a psy, right)?

Hi Heikki,

Looks like that would pretty much make it reflect the same values as
"tcpm-source-psy-" exposed
by tcpm. So experimenting with making the charger power supply a supplicant.
However, noticed that the "tcpm-source-psy-" does not have calls to
power_supply_changed().
So the notifiers are not getting invoked.
Trying to fix that to see if just "tcpm-source-psy-" helps the case
without me trying to create another
one which almost would reflect the same values. Let me know if you
think that might not work.

For now, refactored the patches to only include changes related to
data path and sending
them in. Will follow up with patches for the charger path once I am
done with the above approach
and some validation.

Thanks,
Badhri
>
>
> thanks,
>
> --
> heikki
