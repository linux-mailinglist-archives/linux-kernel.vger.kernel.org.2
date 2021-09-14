Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FEC40B5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhINRdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhINRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:33:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E88C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:32:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m26so13014927pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qs/nXFozNO4XKGck5LQAgcVnI2HZwI8WrVsYnHtpC94=;
        b=RJypP0ZEIzGrEzxsJiZ3f0EhlTI1eSOUL1RNtKf3JNQjS/D/d/8TfWrRamUe+4uj8F
         +9R28NsHtXqgtoLOrQuCinGRhCU5+xPekYQzfQkk4KeTx+NqAgCJ/jOHs2EB63+fWZ28
         CiVZ8vUPO+r3bA0nU12WHmTBuzxoVY6LkE+nsMbPacqfdTYzSBmV1BvmMGBi2N7L8Ndt
         Hk4QaqGHrrANd5wG9uK+GLpVubcflZiUE2P84BsEL/S+6AU5sZaqw+iucEOwT7NQKczB
         7Vfk8LbYYQh5hlbchTgQzdJZuGbUwSnTD4t6hMWx42JAg0EPigS1trYjsclzOmxN5dWG
         iORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qs/nXFozNO4XKGck5LQAgcVnI2HZwI8WrVsYnHtpC94=;
        b=EnT6RRzdYz0js1fxbhdkMhfrzpSKMR0nHHIk19chkuAUkLDQ1pKh8flms+r8r2ntz1
         8M5clArh4f6Ts6qA4ED3uvIroN2YsZkkbZDwl76LDI30oPKQ+ki9VNZ/ifq4sKzsw8+x
         dE1DGnSwjqxs50gX328VkryISYdnPXddeD/0wdyO8Ofh+zWbY8rIRY5UdoG8mh6eqJ4h
         TVcqSljdJFBrK0KVkVfS9sarLSHnUqYHNsXBByz/B5u3ioh4AGg+3NS4pWCjySTav+3m
         DUn/hHLPeG9HybpH9yUbwYK/TNCOWA13LxIygPuyDCW+bBUmLK0pEtcWpAxcvzLW4kRr
         HDAQ==
X-Gm-Message-State: AOAM531g5aEs8x/pDyk46A/1AIkvQLGqSh+0SHNxWyB/bRymNiPqzQDG
        zLWkBaFg0uOIFsmIV4ZDlLCG85OnnSYcHYGC241n/w==
X-Google-Smtp-Source: ABdhPJzDzncI+LLQAAhny8Ap5U3EtD5ysxI4W4mAYPPv4hTxXCM6lWOIjIHDh73AM/ND2P94HzpZw9Fi2MW9SJdt/Ps=
X-Received: by 2002:a62:e70c:0:b0:43e:2de6:b09d with SMTP id
 s12-20020a62e70c000000b0043e2de6b09dmr134044pfh.9.1631640719199; Tue, 14 Sep
 2021 10:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631629496.git.mchehab+huawei@kernel.org> <cf40784dd4169897f7a28cc4d9393e8eaae5b873.1631629496.git.mchehab+huawei@kernel.org>
In-Reply-To: <cf40784dd4169897f7a28cc4d9393e8eaae5b873.1631629496.git.mchehab+huawei@kernel.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 14 Sep 2021 10:31:23 -0700
Message-ID: <CACK8Z6HzNiVXxcW+yokW+db6-A5VgxixdzE-5B=tR1_Ph9JORw@mail.gmail.com>
Subject: Re: [PATCH v2 01/29] ABI: sysfs-bus-usb: better document variable argument
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 7:32 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> On almost all ABI documents, variable arguments are declared
> as <foo_bar>. Change it here too, in order to allow replacing
> such wildcards by regexes on a scriptable way.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

In case it matters:
Acked-by: Rajat Jain <rajatja@google.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-usb | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/=
testing/sysfs-bus-usb
> index 73eb23bc1f34..42103f0f54d6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb
> +++ b/Documentation/ABI/testing/sysfs-bus-usb
> @@ -166,14 +166,14 @@ Description:
>                 The file will be present for all speeds of USB devices, a=
nd will
>                 always read "no" for USB 1.1 and USB 2.0 devices.
>
> -What:          /sys/bus/usb/devices/.../(hub interface)/portX
> +What:          /sys/bus/usb/devices/.../<hub_interface>/port<X>
>  Date:          August 2012
>  Contact:       Lan Tianyu <tianyu.lan@intel.com>
>  Description:
> -               The /sys/bus/usb/devices/.../(hub interface)/portX
> +               The /sys/bus/usb/devices/.../<hub_interface>/port<X>
>                 is usb port device's sysfs directory.
>
> -What:          /sys/bus/usb/devices/.../(hub interface)/portX/connect_ty=
pe
> +What:          /sys/bus/usb/devices/.../<hub_interface>/port<X>/connect_=
type
>  Date:          January 2013
>  Contact:       Lan Tianyu <tianyu.lan@intel.com>
>  Description:
> @@ -182,7 +182,7 @@ Description:
>                 The file will read "hotplug", "hardwired" and "not used" =
if the
>                 information is available, and "unknown" otherwise.
>
> -What:          /sys/bus/usb/devices/.../(hub interface)/portX/location
> +What:          /sys/bus/usb/devices/.../<hub_interface>/port<X>/location
>  Date:          October 2018
>  Contact:       Bj=C3=B8rn Mork <bjorn@mork.no>
>  Description:
> @@ -192,7 +192,7 @@ Description:
>                 raw location value as a hex integer.
>
>
> -What:          /sys/bus/usb/devices/.../(hub interface)/portX/quirks
> +What:          /sys/bus/usb/devices/.../<hub_interface>/port<X>/quirks
>  Date:          May 2018
>  Contact:       Nicolas Boichat <drinkcat@chromium.org>
>  Description:
> @@ -216,7 +216,7 @@ Description:
>                    used to help make enumeration work better on some high=
 speed
>                    devices.
>
> -What:          /sys/bus/usb/devices/.../(hub interface)/portX/over_curre=
nt_count
> +What:          /sys/bus/usb/devices/.../<hub_interface>/port<X>/over_cur=
rent_count
>  Date:          February 2018
>  Contact:       Richard Leitner <richard.leitner@skidata.com>
>  Description:
> @@ -230,10 +230,10 @@ Description:
>                 Any time this value changes the corresponding hub device =
will send a
>                 udev event with the following attributes::
>
> -                 OVER_CURRENT_PORT=3D/sys/bus/usb/devices/.../(hub inter=
face)/portX
> +                 OVER_CURRENT_PORT=3D/sys/bus/usb/devices/.../<hub_inter=
face>/port<X>
>                   OVER_CURRENT_COUNT=3D[current value of this sysfs attri=
bute]
>
> -What:          /sys/bus/usb/devices/.../(hub interface)/portX/usb3_lpm_p=
ermit
> +What:          /sys/bus/usb/devices/.../<hub_interface>/port<X>/usb3_lpm=
_permit
>  Date:          November 2015
>  Contact:       Lu Baolu <baolu.lu@linux.intel.com>
>  Description:
> --
> 2.31.1
>
