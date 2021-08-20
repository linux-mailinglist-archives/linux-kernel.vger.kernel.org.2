Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969073F2CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhHTNCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbhHTNCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:02:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1CAC061575;
        Fri, 20 Aug 2021 06:01:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so6066916wml.3;
        Fri, 20 Aug 2021 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xzeaFa3UNgKzx3RirfcqUDpgF3zRTrOXaQu0yTtjAs8=;
        b=fgw8GLAuc2MNfD/+BeMNlU9PO4RFELR0coeE9WvYMM6en3SUIt4B1BkiWfiFM+hWlz
         NjcPpBeHyoKVUPi8WcBLhDdT13zAHdFfLIQttIfEu4fvlkTSykc0lCVAGkT5Ih9MZTBk
         ZJWTQKJk2TKDSPUd6oy9iDE5AIKm7x5O5FUehQROqvFgyh8qCM7/i0q5f8SUOy62Q1Fa
         fymQP10CnFPNK2mGRW5uz6BM5Awt1pi4DxXGNQsvKQ/ZmGdawliSOenIpoVp6tjvBn+K
         81LG0R4QvI+mXLCH4fqCxBQo84renKkrEc6eO3F9n1zXXgHv5jyTuJT3gf8iy9OcxGo+
         Stpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xzeaFa3UNgKzx3RirfcqUDpgF3zRTrOXaQu0yTtjAs8=;
        b=QdRPROlwSDKP7pKj2KpxQlUmFRrroCP/3e2BIAGKwYhk2I+LL8wAY/jVb+4yjunBmM
         xWhYjUA4t5x6hEmW11Sdfr621lC3Df1aCbxinjMj4nmT7HVJIy/s8bu0cDazSCjn/Lcz
         n134PlzX/toRsuv8lxwqL4J3oCGYh0XvNRMmVZHI1xZbHZ1gDq06jizs1+YcvUV+bGw+
         PqbNP90pAuTFnHgiT+tC6PsFfuneq2DEijjvT18e1eJq0O6xPy57H5h3GfNGM7Mzbmy9
         mqih5mtIPsUo8MARs0f4cyOQeOR2MiS87WQceCiZeaS+YMJlc32v0fDMLYZLmF9OBNjM
         EraA==
X-Gm-Message-State: AOAM530pJIknVGOoFS/Rxf47iF6b1RXiQk07kAzo0L/5RO03mSjOpDNb
        cHbmSJRadh4HoV6xKm2Qf0A=
X-Google-Smtp-Source: ABdhPJw/LR6bwOPyFSF2PYKaqncGa5GZ6mZ9HM+Ej42fjqEdm+pqppMxsGO9Km3nNKhVt5iHys1eow==
X-Received: by 2002:a1c:7e8a:: with SMTP id z132mr3823139wmc.75.1629464514759;
        Fri, 20 Aug 2021 06:01:54 -0700 (PDT)
Received: from lorien (lorien.valinor.li. [2a01:4f8:192:61d5::2])
        by smtp.gmail.com with ESMTPSA id k22sm5026185wmi.47.2021.08.20.06.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 06:01:54 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Fri, 20 Aug 2021 15:01:53 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Benjamin Berg <bberg@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ian Turner <vectro@vectro.org>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <YR+nwZtz9CQuyTn+@lorien.valinor.li>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
 <20201028091043.GC1947336@kroah.com>
 <20201106104725.GC2785199@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106104725.GC2785199@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Nov 06, 2020 at 11:47:25AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Oct 28, 2020 at 10:10:43AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Oct 09, 2020 at 04:40:45PM +0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <bberg@redhat.com>
> > > 
> > > Hi all,
> > > 
> > > so, I kept running in an issue where the UCSI port information was saying
> > > that power was being delivered (online: 1), while no cable was attached.
> > > 
> > > The core of the problem is that there are scenarios where UCSI change
> > > notifications are lost. This happens because querying the changes that
> > > happened is done using the GET_CONNECTOR_STATUS command while clearing the
> > > bitfield happens from the separate ACK command. Any change in between will
> > > be lost.
> > > 
> > > Note that the problem may be almost invisible in the UI as e.g. GNOME will
> > > still show the battery as discharging. But some policies like automatic
> > > suspend may be applied incorrectly.
> > > 
> > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > 
> > > Benjamin Berg (2):
> > >   usb: typec: ucsi: acpi: Always decode connector change information
> > >   usb: typec: ucsi: Work around PPM losing change information
> > 
> > Do these need to be backported to stable kernel releases?  If so, how
> > far back?
> 
> Due to the lack of response, I guess they don't need to go to any stable
> kernel, so will queue them up for 5.11-rc1.

At least one user in Debian (https://bugs.debian.org/992004) would be
happy to have those backported as well to the 5.10.y series (which we
will pick up).

So if Benjamin ack's this, this would be great to have in 5.10.y.

Regards,
Salvatore
