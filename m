Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5639DA14
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFGKt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:49:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50306 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFGKt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:49:59 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70F4C1FDA5;
        Mon,  7 Jun 2021 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623062887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iwf+7I0qD+iYIYXypUMOZrY7NC8vYclySCnJ8RyP60E=;
        b=l0clv/Ey9u3JZcTSd4VMItu30ryfflQQMXORRwcAoT9s8jGZjRD6lL1BUUHmG4jB5dyJjQ
        KB4LsUEK/Vi4I4G0/Qs0sH5wOHkmgJ6P5v+FZ95njukRQRzI+stjMeBFy8h/dgMFejrpv4
        OzE91MBBRtjPqN8fzlApaDwf4tTLtXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623062887;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iwf+7I0qD+iYIYXypUMOZrY7NC8vYclySCnJ8RyP60E=;
        b=s8PK2PDR0jd+mwiLOwUioxBTHpWcDNRA6zDXnrKq1sS6mGNI4NJOwK+Zrsip2zLiHMfQf3
        tvIvXPDLNisnNSCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2FFC6118DD;
        Mon,  7 Jun 2021 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623062887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iwf+7I0qD+iYIYXypUMOZrY7NC8vYclySCnJ8RyP60E=;
        b=l0clv/Ey9u3JZcTSd4VMItu30ryfflQQMXORRwcAoT9s8jGZjRD6lL1BUUHmG4jB5dyJjQ
        KB4LsUEK/Vi4I4G0/Qs0sH5wOHkmgJ6P5v+FZ95njukRQRzI+stjMeBFy8h/dgMFejrpv4
        OzE91MBBRtjPqN8fzlApaDwf4tTLtXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623062887;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iwf+7I0qD+iYIYXypUMOZrY7NC8vYclySCnJ8RyP60E=;
        b=s8PK2PDR0jd+mwiLOwUioxBTHpWcDNRA6zDXnrKq1sS6mGNI4NJOwK+Zrsip2zLiHMfQf3
        tvIvXPDLNisnNSCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id BcxtCGf5vWCIQQAALh3uQQ
        (envelope-from <lhenriques@suse.de>); Mon, 07 Jun 2021 10:48:07 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 6266486c;
        Mon, 7 Jun 2021 10:48:06 +0000 (UTC)
Date:   Mon, 7 Jun 2021 11:48:06 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] gcov: add basic gcov_info validation to gcov
 initialization
Message-ID: <YL35Zuk1urUn086g@suse.de>
References: <YLZYwgs5hyzFZMlw@suse.de>
 <20210602102455.11724-1-lhenriques@suse.de>
 <f0148fb8-1779-a18e-315c-87df31d3154f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0148fb8-1779-a18e-315c-87df31d3154f@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:59:45AM +0200, Peter Oberparleiter wrote:
> On 02.06.2021 12:24, Luis Henriques wrote:
> > Add a basic gcov_info struct validation helper to gcc to ensure we have
> > sane from the compiler.
> > 
> > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > ---
> > Hi!
> > 
> > I know this won't really validate the gcov_info struct, but it will at
> > least prevent kernel crashes in simple scenarios (such as the one I'm
> > seeing with gcc 9.3.1).
> 
> Thanks for your suggestion of adding validity checking for the gcov_info
> struct. The goal you aim at is definitely something that we want to have
> to reduce the impact of fallout from changes to GCC's gcov_info struct.
> 
> In my opinion though the approach you described - looking at the
> contents of specific fields in gcov_info - isn't the correct way to go
> forward. Since you cannot know how gcov_info changed, accessing any data
> in it is very dangerous. Even if there's no out-of-bounds access (if the
> struct's size was reduced) the field you are checking could have moved
> elsewhere so the meaningfulness of the check is very limited.
> 
> In a previous discussion on the same topic I proposed a different
> approach for a build-time check that would fully check the compatibility
> of kernel code and GCC-emitted gcov-related data structures. See:
> 
> https://lore.kernel.org/patchwork/patch/1393585/#1592411
> 

Thanks, I see the problem is way more complex and I understand that my
patch is just wrong.  Thanks for pointing me at this thread.

> Unfortunately I have not yet found the time to implement this approach
> but it's still on my to-do-list.
> 
> Regarding the cause of the error you're seeing I'll have a look at the
> corresponding GCC source to see if there's anything that could be
> causing the issue.

Great, thanks.  Let me know if you need me to provide more info or
testing.  I'll be glad to help.

Cheers,
--
Luís
