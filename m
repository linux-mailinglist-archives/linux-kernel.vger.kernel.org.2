Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C0E422BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhJEPBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:01:40 -0400
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:34622 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231663AbhJEPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:01:36 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BBB192774C;
        Tue,  5 Oct 2021 14:59:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 414E320D76E;
        Tue,  5 Oct 2021 14:59:44 +0000 (UTC)
Message-ID: <3ee1984f331b6b283f95bed303dc3d3e7e363460.camel@perches.com>
Subject: Re: [PATCH 01/13] usb: core: config: Use tabs rather than spaces
 for new lines of args
From:   Joe Perches <joe@perches.com>
To:     Robert Greener <rob@robgreener.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 05 Oct 2021 07:59:43 -0700
In-Reply-To: <3e27773cc94bfc740374d0432e70e4b215c08c9a.1633442131.git.rob@robgreener.com>
References: <cover.1633442131.git.rob@robgreener.com>
         <3e27773cc94bfc740374d0432e70e4b215c08c9a.1633442131.git.rob@robgreener.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 414E320D76E
X-Spam-Status: No, score=0.10
X-Stat-Signature: npk88fekj6em1j8f3strzcdms13g4ymz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ykvpIhNf6YUa47ef+eWtBvFbQYbXMvuY=
X-HE-Tag: 1633445984-646722
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-05 at 13:22 +0100, Robert Greener wrote:
> This fixes the following checkpatch.pl warning at lines 28, 499, 500, 606:

Please do not bcc an entire patch set.

> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
[]
> @@ -496,8 +496,8 @@ void usb_release_interface_cache(struct kref *ref)
>  }
>  
>  static int usb_parse_interface(struct device *ddev, int cfgno,
> -    struct usb_host_config *config, unsigned char *buffer, int size,
> -    u8 inums[], u8 nalts[])
> +		struct usb_host_config *config, unsigned char *buffer, int size,
> +		s[], u8 nalts[])

And don't send patches that likely don't compile.

A patch described as a whitespace only patch should not change
anything other that whitespace.


