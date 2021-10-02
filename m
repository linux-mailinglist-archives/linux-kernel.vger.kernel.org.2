Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C5741FE46
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 23:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhJBVgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbhJBVgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:36:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B68C061714;
        Sat,  2 Oct 2021 14:34:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i25so53589254lfg.6;
        Sat, 02 Oct 2021 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:cc:subject:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sr7zpoMXlNOqHgczAlk6ZgoWjf6JMJ+TU28A00eG/Uw=;
        b=Ykn+zz4p4l24vq8JxMWjB6NcFHM7zS5WXz52Rj65EHo4+Krjz9bgJ+Ka3o0BFrWm6Y
         qvXFuMJQDShXVoWZs9Oewtau2kw3JITOd5/HuOxRV7vwXbxZ2AgA7ZWyTQd/e3QFuZS4
         3p+BRrZTIPBwnGEUSJtmtYKY8DsEoyOZU0owgI4CBrZK/I6A8UmhpqP+2d3sxwcj4pm+
         0F+yPnQv1DbZwMFz7CYNPVb9IlLP0QBeQcfwS18qBhjua0U1bXONt3MReavCXAJrK88c
         Fn9F2GAI9wTxn1qfadT5SS209COmfqs0BTOo7vjWHeU819ZRLh9GpUo+Bz2c97Y63kMU
         CzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sr7zpoMXlNOqHgczAlk6ZgoWjf6JMJ+TU28A00eG/Uw=;
        b=uaarjzJzckfOYKXrtwSo+bc/XX0/h+5gCix8fqSuKfOS6L5JAc+ghmEterWrPKtbhl
         FRd+1MAUDdixcj7WHbzu1U8vwUnxc/m8i3QQCq78R7IQH7TvcSlkGlUbd4uuJ0lmnKSu
         38cSqdTmqZU1lrmODgm5gqGO2pWpKkgS9uEYou6pxZi1zLmJWfsVmtHkcLHFke8ccaeT
         lAcHajqsLBOhuk6OX2/mxDV4eZqG2tCpbpXRdhnFtczycTZi5R8i/uE3e5y1ETva8IHd
         6T01dtAV+S9qSJW/SzDMvr9G43EyPjlOtSloXTPN7soda/RSjGSEv7ZDv6FjY9YlGHb2
         pbbg==
X-Gm-Message-State: AOAM530IgzEdrvQjb67WAF9MLCikeIoX2u21APNNdmBSqKSZwbR9WF7s
        FAD3bGHHvKbiOWXsrjE7A58=
X-Google-Smtp-Source: ABdhPJx+rDNyNSeCgX4mr7KHsYLnTzAeRX68ElJgpte2wb9TFdHbovKNruevbJC+sUvfg6tSu3b2BA==
X-Received: by 2002:a2e:a787:: with SMTP id c7mr6024923ljf.264.1633210465425;
        Sat, 02 Oct 2021 14:34:25 -0700 (PDT)
Received: from penguin.lxd (105-28-94-178.pool.ukrtel.net. [178.94.28.105])
        by smtp.gmail.com with ESMTPSA id h1sm161757lfk.161.2021.10.02.14.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:34:25 -0700 (PDT)
Date:   Sun, 3 Oct 2021 00:34:10 +0300
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/3] Update ASUS WMI supported boards.
Message-ID: <20211003003410.28248af4@penguin.lxd>
In-Reply-To: <20211002210857.709956-1-pauk.denis@gmail.com>
References: <20211002210857.709956-1-pauk.denis@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Oct 2021 00:08:53 +0300
Denis Pauk <pauk.denis@gmail.com> wrote:

Patches should be applied over
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git:hwmon-next
(0889b7c73a4d8eaaa321eafcf66835979ead862a)

> Add support to nct6775:
> * PRIME B360-PLUS
> * PRIME X570-PRO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX B550-I GAMING
> * ROG STRIX X570-F GAMING
> * ROG STRIX Z390-E GAMING
> * TUF GAMING B550-PRO
> * TUF GAMING Z490-PLUS
> * TUF GAMING Z490-PLUS (WI-FI)
> 
> Add sensors driver for ASUS motherboards to read sensors from the
> embedded controller. Based on
> https://github.com/zeule/asus-wmi-ec-sensors.
> 
> Could you please review?
> 
> @Andy Shevchenko, @Guenter Roeck should I split last patch in some
> way? Should I add to MAINTAINERS:
> --
> ASUS WMI HARDWARE MONITOR DRIVER
> M:     Eugene Shalygin <eugene.shalygin@gmail.com>
> M:     Denis Pauk <pauk.denis@gmail.com>
> L:     linux-hwmon@vger.kernel.org
> S:     Maintained
> F:     drivers/hwmon/asus_wmi_sensors.c
> --
> 
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Tested-by: matt-testalltheway <sefoci9222@rerunway.com>
> Tested-by: Kamil Dudka <kdudka@redhat.com>
> Tested-by: Robert Swiecki <robert@swiecki.net>
> Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>
> Tested-by: Igor <igor@svelig.com>
> Tested-by: Tor Vic <torvic9@mailbox.org>
> Tested-by: Poezevara <nephartyz@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> 
> ---
> Denis Pauk (3):
>   hwmon: (nct6775) Add additional ASUS motherboards.
>   hwmon: (nct6775) Use custom scale for ASUS motherboards.
>   hwmon: (asus_wmi_sensors) Support access via Asus WMI.
> 
>  drivers/hwmon/Kconfig            |  12 +
>  drivers/hwmon/Makefile           |   1 +
>  drivers/hwmon/asus_wmi_sensors.c | 595
> +++++++++++++++++++++++++++++++ drivers/hwmon/nct6775.c          |
> 41 ++- 4 files changed, 643 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/hwmon/asus_wmi_sensors.c
> 

