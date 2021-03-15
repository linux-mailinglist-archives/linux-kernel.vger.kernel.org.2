Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B01F33B319
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhCOMzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhCOMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:54:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D28BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:54:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r3so48474958lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fCsQIb1jn2XjkQlKHlfGz2Q6iPdpxgndOFN/petF/Ck=;
        b=lkEhAPPdEXytIdWVfWvhIMX8jcye05r+9TTD26j/sjDXaxdzv7N6iMvDkLVO68UYGK
         1cXggxleCGVkQQjimVgmbCOA4h0N64i6ECtTiOQ1Dn5Kq8MmghpVnWNM3mhpObRk/fFv
         THapqtLO285ELtQgaBxxj1Kx5xJQjbSWWPcc4Q1d4jgprxT9cQBfU7pbow+v5IKNKdR2
         QRQOAnwnotrduFK/mC2o2+Z36idErwnyiKh4Hp6J5su3LVPAFX1CsukCzGVRQ7UDaPym
         DVG1CnRe7we/4Glxnwb2db23Dd0SbE0YNUkWYdMuDWj35FQZkS3azFypGIRen7vbFDnN
         1lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fCsQIb1jn2XjkQlKHlfGz2Q6iPdpxgndOFN/petF/Ck=;
        b=DSo/S2ixRmWFHf7M8XrK2vvTqhI86BeHA0r5cetF0Cgte5Th95qf0xfswgOJkEfaZR
         ssS0capIAmx3Za23Z2sYGr/Vyj8pGA+wkW57oq3vfoS+xpFxtSgxgMMl7iGXy6WIlQXv
         G7yU2nlHl+IRx0pqh0XXxw5SAWZwg7rKGhT9tB1KUZ52afwTGlnZOC826ncokQ9w9Llb
         FI/JYKrcVVybPQhaYq2J5oPAWrhQAnHmBxh3bI/uZaXpjJaWZx5HMjL1YNjGSA3viKBy
         0vaAeMvqZybngUfZmN+q2eZjPLsu28MZJYpgIi3erJlcu1OC76QD2bRdGtE4SBGyOBb5
         F+uw==
X-Gm-Message-State: AOAM531v8wgwU/gVP5QsOxnf45+qx95ZASgyuHWD3PHhvfi+JwXImVjy
        AL1BebMYAnAenXJmP2FGAhQ=
X-Google-Smtp-Source: ABdhPJzjteMQFY5GcpdnzfBwMPIwaFmEFXUPKAPCMiPMOw+6J1B6sOEMXVGlCobnyEfDzfa/8KsTGQ==
X-Received: by 2002:a05:6512:3290:: with SMTP id p16mr7811570lfe.150.1615812892535;
        Mon, 15 Mar 2021 05:54:52 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id o22sm2896429ljh.31.2021.03.15.05.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:54:51 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id BAC9F5601CE; Mon, 15 Mar 2021 15:54:50 +0300 (MSK)
Date:   Mon, 15 Mar 2021 15:54:50 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
Message-ID: <YE9ZGl9jlnDz1OBP@grain>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
 <20210315120803.GA13620@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315120803.GA13620@redhat.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:08:03PM +0100, Oleg Nesterov wrote:
> On 03/14, Alexey Dobriyan wrote:
> >
> > 	prctl(PR_SET_MM, PR_SET_MM_AUXV, addr, 1);
> >
> > will copy 1 byte from userspace to (quite big) on-stack array
> > and then stash everything to mm->saved_auxv.
> 
> I too don't understand, memcpy(mm->saved_auxv, user_auxv, len) will
> copy 1 byte...

Indeed. I overlooked that we pass @len when copying. I should
not reply at night :(

> 
> And why task_lock(current) ? What does it try to protect?

As far as I remember this was related to reading from procfs
at time the patch was written for first time. Looks like this
not relevant anymore and could be dropped.
