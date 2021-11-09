Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72D6449F86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhKIAa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbhKIAay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:30:54 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CDAC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:28:09 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id i13so13098607qvm.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 16:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PIhh11j64GJB5tkkAYeEUi1he5/a0olDT6t9pDlGgAg=;
        b=SrewlxLXy5A5oOJK7Vp265kIB4JFYhK/xcDmhcxns65Y6VpUudY8geHbQmEX53jxSn
         QncDcE/y/hkJNipELIVJZjhy2bcTGXZ0s+akt5WukPtKDQwhVRdNp2eLF9ydsjxKCIng
         /xX0vFqSrLKtA+aRRZkz/EWCkRw/1TKr54qJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIhh11j64GJB5tkkAYeEUi1he5/a0olDT6t9pDlGgAg=;
        b=aPaH3A/NNqyLSS6BSF65VGCHdSyn6DWRBapzu6+x7Z+RCFygFrlIE1FJsUBLwahP8v
         4nPVfz205DqTqLWjTRpCJ/hiAWWVndmf7SJNzzgo1Ep9+xlfwsTUvYRR5HVA8PYp/UUX
         sqoTOUFO5sIXsEDOh0LOxodvg3parQwx1klnCJ6sTOd3QMxvUkPFNOYACTH1crWIP5AE
         SVqKSb/RacZKLZbOxs/4lQYcaGH+aBuHpEp/YUIZ/GqRuaPxvYbT4+rm3Gl/4O2kPD67
         AJBJYv/5vwxVR0rjcZoDsoeLACDpXY/8/Q4N74I57DR+I6wc8xVsi4EPasYde4B3lFVH
         U94w==
X-Gm-Message-State: AOAM532q9lOfCZ9+yvF1MJ2RWhKxG8KjcyPMnYSQ1QIfZSbAcL1z5UiN
        p2u6tq72e0JHxibR8LnHBnVottuz+cpM4ioAKNYjJA==
X-Google-Smtp-Source: ABdhPJyy7zFreyFzm0oVAJnF+Wv+Xx1CS7ENHrac3M4N9cvTpQpGSxXw+AwFyiXgc0nhR5tLeK5whJdo4uj4i4ezbU0=
X-Received: by 2002:a05:6214:21ea:: with SMTP id p10mr2981168qvj.67.1636417688528;
 Mon, 08 Nov 2021 16:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
 <20211026143352.78387-3-heikki.krogerus@linux.intel.com> <YXn2zCA9lasDY/Xl@google.com>
 <YXpS58zozw93QXig@kuha.fi.intel.com>
In-Reply-To: <YXpS58zozw93QXig@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 8 Nov 2021 16:27:56 -0800
Message-ID: <CACeCKaeAV13=o_G6B3nF+4PRv95OzO3j0kSTjdT8Lpzs3-a1bA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] usb: typec: Character device for USB Power
 Delivery devices
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Thu, Oct 28, 2021 at 12:36 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Oct 27, 2021 at 06:03:08PM -0700, Prashant Malani wrote:
> > Why is USBPDDEV_SUBMIT_MESSAGE different from USBPDDEV_SET_MESSAGE?
> > Shouldn't "setting" a PDO or property automatically "submit" it (using TCPM
> > or whatever interface is actually performing the PD messaging) if
> > appropriate (e.g Source Caps?). Is there a situation where one would
> > want to "set" a property but not "send" it?
> >
> > It seems to me that the two can be combined into 1 rather than having
> > a separate command just for ports.
>
> USBPDDEV_SUBMIT_MESSAGE you use to send message directly to the partner.
>
> USBPDDEV_SET_MESSAGE is meant to be used to store the values to a
> cached message that the port manager should use next time there is
> communication, but it does not send the message to the partner. So you
> can use it even when there is no connection with a port, for example,
> to store the values like the initial USB mode that should be used by
> setting the EUDO message. Maybe the ioctl should be named
> USBPDDEV_STORE_MESSAGE... I used "set" because it is sort of a
> counterpart to USBPDDEV_GET_MESSAGE.
>
> There is an explanation in include/uapi/linux/usb/pd_dev.h, please
> check it.

Thanks for the further clarification. I guess I still don't see enough
need to differentiate SET/STORE
from SUBMIT; is there a situation where one would want to store the
source/sink caps for a port,
but not send/submit them immediately? When a partner is not connected
to a port, a set would
automatically just update the cached values and not perform a "submit"
(since there is nothing to
submit to). Perhaps there are (situations which require separate store
and submit), but I'm unable
to come up with one on the spot.

I'm curious also what you think about the idea with
> USBPDDEV_CONFIGURE.

It is indeed interesting. It seems like the specific interface for
this needs to be fleshed out more (will we
define a standard set of features which can be represented by the
|flags| and made configurable?). At present
I can't think of TCPM features which we'd want to toggle at runtime,
but I'm looking at it from a Chrome OS
perspective, so could be missing a bunch of use cases.

BTW, does poll work with this character device?

Best regards,
