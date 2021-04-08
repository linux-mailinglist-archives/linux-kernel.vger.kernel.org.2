Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE67357EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhDHJFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:05:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhDHJFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:05:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617872690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iltK01d5af+cgrFEZUWX6FRdwy+PU/iuoHEp7kNrWqY=;
        b=vGH05aUHS9p50eqCjbT5JaY1Yvw3q0NrAY2X7kbk5W330yke4rShHaqeDBV1StzMZcSOTB
        XRstldq8Dsc0Trhe3CspZLxobWLPD5yoKd6SWdQuxQ1nb5Djga5RO3WDM5uRk7oobPbM0t
        Xqu9j9SkcLnNrrtgWyOiUjt2/Bh8onQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E29FAFF6;
        Thu,  8 Apr 2021 09:04:50 +0000 (UTC)
Message-ID: <8918b0b50068705a865ffc22fe9745dacf0c21e8.camel@suse.com>
Subject: Re: [PATCH 2/3] USB: cdc-acm: fix unprivileged TIOCCSERIAL
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 09:48:38 +0200
In-Reply-To: <20210407102845.32720-3-johan@kernel.org>
References: <20210407102845.32720-1-johan@kernel.org>
         <20210407102845.32720-3-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 07.04.2021, 12:28 +0200 schrieb Johan Hovold:
> TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
> serial devices is only useful for setting the close_delay and
> closing_wait parameters.
> 
> A non-privileged user has only ever been able to set the since long
> deprecated ASYNC_SPD flags and trying to change any other *supported*
> feature should result in -EPERM being returned. Setting the current
> values for any supported features should return success.
> 
> Fix the cdc-acm implementation which instead indicated that the
> TIOCSSERIAL ioctl was not even implemented when a non-privileged user
> set the current values.

Hi,

the idea here was that you are setting something else, if you are
not changing a parameter that can be changed. That conclusion is
dubious, but at the same time, this implementation can change
only these two parameters. So can the test really be dropped
as opposed to be modified?

	Regards
		Oliver


