Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DFE40C520
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbhIOMWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:22:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50176 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhIOMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:22:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A9D5B2223B;
        Wed, 15 Sep 2021 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631708493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1Iph1gSdH9FBZgY2AvdK6unYOt+Qq5SLnxNu8KaS5o=;
        b=A0ttEjIvf3D6ExYxY9uVcitKA61Z97Ouy7/3+s5FxGsqNCaftyOB5OdEWZgQnpWAux8I/q
        s5KYCjs9uZI7ADw4CvjZ+9jEAO+yYoemDDq3yC0kvozoMQSHneb+9i0axVOz0sFZ1AwirL
        qChu+PmkRuyrSTQTb+XsmR4qSmqABxM=
Received: from boxie.home.nordisch.org (mrueckert.tcp.ovpn2.nue.suse.de [10.163.34.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6FBEDA3B99;
        Wed, 15 Sep 2021 12:21:33 +0000 (UTC)
Received: from fortress.home.nordisch.org ([192.168.1.3])
        by boxie.home.nordisch.org with ESMTPSA
        id 9ewjGk3lQWENXQAA3JBPWg
        (envelope-from <mrueckert@suse.com>); Wed, 15 Sep 2021 12:21:33 +0000
Date:   Wed, 15 Sep 2021 14:21:23 +0200
From:   Marcus =?UTF-8?B?UsO8Y2tlcnQ=?= <mrueckert@suse.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/umip: Add a umip= cmdline switch
Message-ID: <20210915142123.49f8137b@fortress.home.nordisch.org>
In-Reply-To: <20210915113410.GA7130@ranerica-svr.sc.intel.com>
References: <20210907200454.30458-1-bp@alien8.de>
        <20210911011459.GA11980@ranerica-svr.sc.intel.com>
        <YTx0+0pfyzHuX80L@zn.tnic>
        <20210913213836.GA10627@ranerica-svr.sc.intel.com>
        <YUDTCgEOZ3JOMSl7@zn.tnic>
        <20210915113410.GA7130@ranerica-svr.sc.intel.com>
Organization: SUSE GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 04:34:10 -0700
Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > They're all likely old, arcane applications or games run in wine
> > which people have no access to the source code anyway so come to
> > think of it, the once thing is starting to make more sense to me
> > now.
> 
> Indeed, no one has reported "modern" application using these
> instructions.

I am not sure if Blizzard Entertainment would tell us why they use this
CPU instruction in Overwatch. And that game is "only" 5 years old.

   darix

-- 
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.
