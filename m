Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4793A2933
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFJKUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:20:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52566 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFJKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:20:04 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1E7E91FD47;
        Thu, 10 Jun 2021 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623320288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxfZ/02R8xE6a4oEqBNeW4C/D88lDWt4iEvfVEmD0G4=;
        b=iWvHOcUD5hEF9FKYjZ9eNZ+QcsHoSlAqFM6awUrQgDzAERqxv3V+dv9RaFXv4fm813dh6t
        ZbzDHAt4wrMW/qw5GZ861phMK+ySGcdTyIbW5kzjcqLqOXzCKvS8vOuM6AvgvH1PLnUqQk
        saPFIV94/bcV0GdVFNFBOWOe/ukXx1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623320288;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxfZ/02R8xE6a4oEqBNeW4C/D88lDWt4iEvfVEmD0G4=;
        b=Gsc568b+oQEWCnSqSh4tQ57+FDykkcE2+jTJeD3EkmJ87OxmubPY5VSiacX5fP37mJpvmi
        tCs9/1xMyJRbeyCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id EE88F118DD;
        Thu, 10 Jun 2021 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623320288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxfZ/02R8xE6a4oEqBNeW4C/D88lDWt4iEvfVEmD0G4=;
        b=iWvHOcUD5hEF9FKYjZ9eNZ+QcsHoSlAqFM6awUrQgDzAERqxv3V+dv9RaFXv4fm813dh6t
        ZbzDHAt4wrMW/qw5GZ861phMK+ySGcdTyIbW5kzjcqLqOXzCKvS8vOuM6AvgvH1PLnUqQk
        saPFIV94/bcV0GdVFNFBOWOe/ukXx1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623320288;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxfZ/02R8xE6a4oEqBNeW4C/D88lDWt4iEvfVEmD0G4=;
        b=Gsc568b+oQEWCnSqSh4tQ57+FDykkcE2+jTJeD3EkmJ87OxmubPY5VSiacX5fP37mJpvmi
        tCs9/1xMyJRbeyCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id FZ6qOd/mwWDWWAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Thu, 10 Jun 2021 10:18:07 +0000
Subject: Re: [PATCH v11] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org
References: <1623141934-7699-1-git-send-email-faiyazm@codeaurora.org>
 <CAHp75VcwW6RGALAjzcK4W9xy_hDPyFti4cNY_pCwJnjUr+VYVQ@mail.gmail.com>
 <b84892d5-06ed-fdbe-b5b3-0956140573ec@codeaurora.org>
 <78fc8848-bde8-769e-f8e9-6157d232a60f@suse.cz>
 <47842d8d-2747-3d0f-8695-122dc23d90e6@codeaurora.org>
 <7d652fca-23f3-fc03-c7b2-310edcafebb3@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bcffcdba-3821-00bd-7d62-1a046d287f11@suse.cz>
Date:   Thu, 10 Jun 2021 12:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <7d652fca-23f3-fc03-c7b2-310edcafebb3@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/21 10:56 AM, Faiyaz Mohammed wrote:
> Hi Andy,
> 
> On 6/8/2021 11:43 PM, Faiyaz Mohammed wrote:
>> 
>> 
>> On 6/8/2021 11:05 PM, Vlastimil Babka wrote:
>>> On 6/8/21 7:11 PM, Faiyaz Mohammed wrote:
>>>>
>>>>
>>>> On 6/8/2021 5:20 PM, Andy Shevchenko wrote:
>>>> Hmmm, I think to avoid same version problem I have to push same patch
>>>> with new version number and thank you for your patience.
>>>
>>> I *think* Andrew wouldn't have this issue, so maybe resend only if he says it's
>>> needed.
>> Sure, I will send if he ask.
> Do I need to send patch with new version number?.

If you send a v12 patch that's not malformed, and with my reviewed-by added, it
can't hurt.
