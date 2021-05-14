Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6F380D37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhENPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:34:58 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43853 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231273AbhENPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:34:57 -0400
Received: (qmail 1009443 invoked by uid 1000); 14 May 2021 11:33:45 -0400
Date:   Fri, 14 May 2021 11:33:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     chris.chiu@canonical.com
Cc:     gregkh@linuxfoundation.org, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] USB: propose a generic fix for PORT_SUSPEND set
 feature timeout
Message-ID: <20210514153345.GB1007561@rowland.harvard.edu>
References: <20210514045405.5261-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514045405.5261-1-chris.chiu@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 12:54:03PM +0800, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> For the Realtek Hub which fails to resume the port which has wakeup
> enable descendants, trying to propose a more generic and better fix
> to have the runtime suspend/resume work instead of a reset-resume quirk.
> 
> Chris Chiu (2):
>   USB: Verify the port status when timeout happens during port suspend
>   Revert "USB: Add reset-resume quirk for WD19's Realtek Hub"
> 
>  drivers/usb/core/hub.c    | 21 +++++++++++++++++++++
>  drivers/usb/core/quirks.c |  1 -
>  2 files changed, 21 insertions(+), 1 deletion(-)

For both patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

