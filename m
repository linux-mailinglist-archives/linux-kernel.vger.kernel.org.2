Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544E43581FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhDHLei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhDHLeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:34:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617881664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDIOVgigbNQz2wYXvUtfW44dlC0pAdBtG9TE2EYQHS8=;
        b=Z75+dZcYRxtLlGt8Qfw12bo1a8OYGbZrI8c+G1NJMtOS1MAQYGzDbj2f4Z+d1r8ssOrtQb
        37oOad0lWvKW7juG7jK7mMyyqNzfZfokKN5KRCZ5y09v1V8Mf5Lgdl+QC13k+tY7pUWzcm
        emrh/I3NkpxMy6T1k0qGQAhBsrGMFDw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4DCCB294;
        Thu,  8 Apr 2021 11:34:24 +0000 (UTC)
Message-ID: <0049152ce9da85c50fda91c1b77ca233ba0fef3d.camel@suse.com>
Subject: Re: [PATCH 3/3] USB: cdc-acm: fix TIOCGSERIAL implementation
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 13:34:12 +0200
In-Reply-To: <YG7RiLoscS6VXG7n@hovoldconsulting.com>
References: <20210407102845.32720-1-johan@kernel.org>
         <20210407102845.32720-4-johan@kernel.org>
         <a1a94db2d373c4c7b8841908d8e6133ab022232e.camel@suse.com>
         <YG7RiLoscS6VXG7n@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 08.04.2021, 11:48 +0200 schrieb Johan Hovold:
> On Thu, Apr 08, 2021 at 10:36:46AM +0200, Oliver Neukum wrote:
> > Am Mittwoch, den 07.04.2021, 12:28 +0200 schrieb Johan Hovold:

> > Well, the devices report it. It is part of the standard.
> 
> No, the standard doesn't include anything about a baud-base clock
> AFAICT.

Unfortunately it does.
dwDTERate - chapter 6.3.11 - table 17

If we does this wrongly, we should certainly fix it, but just removing
the reporting doesn't look right to me.

	Regards
		Oliver


