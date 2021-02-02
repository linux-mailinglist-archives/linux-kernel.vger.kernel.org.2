Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A842730BC45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBBKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhBBKmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:42:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9EC061573;
        Tue,  2 Feb 2021 02:41:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EA9A01F44F9C
Subject: Re: [GIT PULL] Immutable Branch between platform/chrome and USB for
 v5.12 merge window
To:     Benson Leung <bleung@google.com>, gregkh@linuxfoundation.org
Cc:     bleung@chromium.org, bleung@kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, linux-kernel@vger.kernel.org
References: <YBkH6wO07sxRDBDo@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cf566f9b-0405-1d5d-6438-c4cf99453928@collabora.com>
Date:   Tue, 2 Feb 2021 11:41:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBkH6wO07sxRDBDo@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/21 9:06, Benson Leung wrote:
> Hi Greg,
> 
> The following changes since commit 29b01295a829fba7399ee84afff4e64660e49f04:
> 
>   usb: typec: Add typec_partner_set_pd_revision (2021-02-01 15:31:34 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-ib-usb-typec-chrome-platform-cros-ec-typec-changes-for-5.12
> 
> for you to fetch changes up to 0371616d8bef6926e9aa05757f35b901268d3724:
> 
>   platform/chrome: cros_ec_typec: Set opmode to PD on SOP connected (2021-02-01 23:49:54 -0800)
> 
> ----------------------------------------------------------------
> cros-ec-typec changes for usb for v5.12
> 
> Chrome OS EC Type-C driver features implemented this round:
> * Registration of cable plug information
> * Support for SOP' plug registration and altmodes
> * Support for reporting number of altmodes supported by partners and plugs
> * Send mux configuration ack to EC via a new host command
> * Reporting SOP' and Partner PD revisions
> 
> ----------------------------------------------------------------
> Benson Leung (4):
>       Merge remote-tracking branch 'origin/cros-ec-typec-for-5.12' into ib-usb-typec-chrome-platform-cros-ec-typec-changes-for-5.12
>       platform/chrome: cros_ec_typec: Report SOP' PD revision from status
>       platform/chrome: cros_ec_typec: Set Partner PD revision from status
>       platform/chrome: cros_ec_typec: Set opmode to PD on SOP connected
> 
> Prashant Malani (8):
>       platform/chrome: cros_ec_typec: Make disc_done flag partner-only
>       platform/chrome: cros_ec_typec: Factor out PD identity parsing
>       platform/chrome: cros_ec_typec: Rename discovery struct
>       platform/chrome: cros_ec_typec: Register cable
>       platform/chrome: cros_ec_typec: Store cable plug type
>       platform/chrome: cros_ec_typec: Set partner num_altmodes
>       platform/chrome: cros_ec_typec: Register SOP' cable plug
>       platform/chrome: cros_ec_typec: Register plug altmodes
> 
> Utkarsh Patel (2):
>       platform/chrome: cros_ec_typec: Parameterize cros_typec_cmds_supported()
>       platform/chrome: cros_ec_typec: Send mux configuration acknowledgment to EC
> 
>  drivers/platform/chrome/cros_ec_typec.c        | 269 +++++++++++++++++++++----
>  include/linux/platform_data/cros_ec_commands.h |  17 ++
>  2 files changed, 243 insertions(+), 43 deletions(-)
> 
> Thanks so much!
> Benson
> 


FWIW this looks good to me. It'd make more easy if all this goes through Greg's
tree instead of our chrome/platform tree. Not sure if is really needed but:

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
  Enric

