Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D5F41D47C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348717AbhI3H1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348599AbhI3H1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:27:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B577AC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 00:25:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 379371F44975
Subject: Re: [PATCH 0/5] platform/chrome: Make cros_ec_pd_command() reusable
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20210930022403.3358070-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ef9908f7-c42d-7d70-074c-8bb36ae3a88c@collabora.com>
Date:   Thu, 30 Sep 2021 09:25:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210930022403.3358070-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,


On 30/9/21 4:23, Prashant Malani wrote:
> This is a short series to relocate and rename cros_ec_pd_command() to
> cros_ec_proto.c. This function is useful for sending host command
> messages, so the 1st 4 patches move it a more central location, and
> modify the arguments to allow other users to use it.
> 

Nice patchset! let's hope we can remove at some point all the custom
implementations in the different cros_ec drivers of the cros_ec_command
function. Give some days to run some tests.

Thanks,
  Enric

> The final patch updates cros-ec-typec to use the new function and get
> rid of its own copy.
> 
> Prashant Malani (5):
>   platform/chrome: cros_usbpd_notify: Rename cros_ec_pd_command()
>   platform/chrome: cros_usbpd_notify: Move ec_command()
>   platform/chrome: cros_ec_proto: Make data pointers void
>   platform/chrome: cros_ec_proto: Add version for ec_command
>   platform/chrome: cros_ec_typec: Use cros_ec_command()
> 
>  drivers/platform/chrome/cros_ec_proto.c     | 48 ++++++++++++++
>  drivers/platform/chrome/cros_ec_typec.c     | 69 ++++++---------------
>  drivers/platform/chrome/cros_usbpd_notify.c | 50 +--------------
>  include/linux/platform_data/cros_ec_proto.h |  3 +
>  4 files changed, 72 insertions(+), 98 deletions(-)
> 
