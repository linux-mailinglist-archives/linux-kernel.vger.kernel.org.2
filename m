Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28D23F4901
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhHWKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbhHWKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:52:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F19DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:52:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g21so25536980edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3cvXcL1EbI/iDDtCobjLWg42RRxXiQlq4y90VtEpZj0=;
        b=TzPtTUwe3SnLYU8MzGeVWn1T8weR0AQfU//PBvCuTJ+RbMxHAhIFdpCHGFwmcZJoOx
         dVu9kNSpU627RwyB7Ifia3CEA8q4lpGgfvDEwjyv18IwMhaZrA4jmYSqlOt8YENf3W2Z
         zvnU82RXYzu2Jm/QO4Fk+XDvcPBVv69wgkj4JmyIGS733ZxWN6y3fFjxpjRUD8S6JYPf
         ADULq2J0SWfR0GXLz3XmnIAG+nn/JMKulpQ8DKLzT4NQCKml2kncvAthjSeSx/8kzXxI
         Lu6oLS+FicrddgZOa53phezM424jXGkPwiDWAC9S0XcQ9VfkaDFMkvBiT++vkY5JSD2L
         qzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cvXcL1EbI/iDDtCobjLWg42RRxXiQlq4y90VtEpZj0=;
        b=V9DBbc03NqfjxaZRSuJg+EOiO3iDZuB18fTBpoA3mC8uoGPIla/X82dOt7zt7ShyoF
         wjAFQ7lURt7J1I57CdoylLZ6S0WY1knKPbBSMx+gLMTo2hl5z6faxz25JPEet9qDDNu/
         1QUQy1CrZ1r2hEXVPxOkyPsSEm7/xkL0cPGGnIMup+n8gBu5iEVDskagHowV9AbZ07ki
         nkFgwoXn6yY0z51WI/WGx5qyRD5Kk6CUjsALRxMSeRNPJ2HJZ1aLuKjBUEo4QCsBhyA5
         vkO/6qFC90DACYjC0IGNGEOqYTyAFomBQCzAIu1vaFF1bmRUZ/90abf6MzQoRMVw53mw
         w5Qg==
X-Gm-Message-State: AOAM533NxenmOynwg89oJnvk4wgSTKP+GdiwSmm5YLw6T5r9NKpt1CsD
        ZLenLkJx0kCozJkztrqScXQ=
X-Google-Smtp-Source: ABdhPJyaYdMFnXAO05iG0gijpnw7nLNMhhj9w03gchjtWiTBYzmZ0Th/ro6njLdDV8qmKkn7YpWn7Q==
X-Received: by 2002:a05:6402:1747:: with SMTP id v7mr37887089edx.19.1629715924880;
        Mon, 23 Aug 2021 03:52:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id ck17sm9015616edb.88.2021.08.23.03.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:52:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH RFC] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Mon, 23 Aug 2021 12:52:03 +0200
Message-ID: <9262363.nlPuahNmOB@localhost.localdomain>
In-Reply-To: <8d37d8e5-7ba5-d49b-f2c5-f7e8844ae8e1@gmail.com>
References: <20210822230235.10953-1-fmdefrancesco@gmail.com> <69bbb80c-2b30-28b9-ad8c-6862a6c3b911@gmail.com> <8d37d8e5-7ba5-d49b-f2c5-f7e8844ae8e1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 23, 2021 10:30:53 AM CEST Pavel Skripkin wrote:
> On 8/23/21 11:11 AM, Pavel Skripkin wrote:
> > On 8/23/21 2:02 AM, Fabio M. De Francesco wrote:
> >> Replace usb_control_msg() with the new usb_control_msg_recv() and
> >> usb_control_msg_send() API of USB Core.
> >> [...]
> >>
> >> @@ -47,19 +47,20 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> >>   		memset(pIo_buf, 0, len);
> >>   
> 		^^^^^^^^^^^^^^^^^^^^^^^
> 
> And this memset becomes useless, since usb_control_msg_recv cannot 
> receive only part of the message
> 
I didn't notice it at all. Obviously, I'll remove it.

Thanks,

Fabio
> 
> With regards,
> Pavel Skripkin
> 




