Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17C312DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhBHJpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:45:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:53912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhBHJjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:39:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612777114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ey4KeQ4wI8Ow8TBhYfMVHQwpaYnFFEiIsiUIit12DQc=;
        b=X3B/SXktu9OMTy3gCQxKfATO0YpQH5xheJaVU3VFlUCboSnM0ZJ3XMUnFDT4Nb0M3RXbQt
        /XfS7+BQnhF2x43SmgC72bRa4C5wB08RgIEcwa/NPXW0LO5bxZTYw4zykSZJ6+jMUiEnYr
        rCEC9iNZdEEoaRqQbhVaGX7lqbQvV44=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EDB9AD62;
        Mon,  8 Feb 2021 09:38:34 +0000 (UTC)
Subject: Re: [PATCH 6/7] xen/evtch: use smp barriers for user event ring
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20210206104932.29064-1-jgross@suse.com>
 <20210206104932.29064-7-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <5cef0d0e-8f03-7cd2-4246-268a67a87dc5@suse.com>
Date:   Mon, 8 Feb 2021 10:38:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210206104932.29064-7-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.2021 11:49, Juergen Gross wrote:
> The ring buffer for user events is used in the local system only, so
> smp barriers are fine for ensuring consistency.
> 
> Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

Albeit I think "local system" is at least ambiguous (physical
machine? VM?). How about something like "is local to the given
kernel instance"?

Jan
