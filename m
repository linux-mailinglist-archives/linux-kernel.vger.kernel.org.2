Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCFE33B501
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhCONxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCONwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:52:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D5AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:52:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z25so16318015lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dy4PRHmstKgNVDldtP4AfAN87fMyz+4pw4KdPsRLyB8=;
        b=bEsEqmLShjpPLJm1IVJ6jucNB38hcg56W6nS6QQ+mxkcLPQtEy/D9K1iMizxd46fqb
         riaAiuU8Vco3PP0s6+H50DC/gcuvZ8Grp/jgnNtP6u23QtKjwQMyBvOrhKbfopH2V4cU
         VKfFloDVl7S/Qpcx8IScT34d15oDsSVhEUYKDNxEBtefzeAq6nV/rVeTlbXz3sIbEkmH
         WMPYms+tF+9G8fevqQAycsy54iS3nDajfaYIKF61FWhNV/ofUy6h7rnPX6laLM0hWvvz
         z//8awNhZyHZNmCpqrE0iUXPD9eMztuFb2Pztc2A3mjo30NLwfnQgHPNI2qthoaM7d6G
         0atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dy4PRHmstKgNVDldtP4AfAN87fMyz+4pw4KdPsRLyB8=;
        b=mMG/IBMMyb8j0GVAI3Pjd2kwln+lcU9c+CVg+yRB5Mvu1388qLnT5MuTtTJIZ99JIj
         9wp4Pv6MLJKJTtHxUpMpHexAJZRTSpPDNV8Vwpa0UcO/D0N6hWUd1s2BK201xF7VzyGy
         +vrjbk5CWTxNWQ0pAzqmbWa7MpUpuyJ0JKw6Zq+b4HRPa8IXlfjghPhJYjUG01YxdDg0
         gpve34uRiUSgaJLuVSNaPI35OKrqB/RYMDZB/gmp4nZdzf84YMhjuPpcCwT7Z1CUaTPu
         b3ng0sX2yQPajnjSJg2JlS2/4pObm/Y83aZUdg1hlLsJ347BtswvDRTcGQugV5bGNLFg
         Hx+A==
X-Gm-Message-State: AOAM533oVSV2k4vvQXao8I9qBnLys1l0LSd+AkdP524IXnPtxmU7uQ4u
        PnIp+w5x8LrTWUL2bULkEI0=
X-Google-Smtp-Source: ABdhPJzm7z5o+3iCJWv0uaSkuOEe3L3+s678nFge6nHeOLKsNx/JEjoDpYnJq+Rmz+jcMS1jd6ZfIw==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr11029534ljg.122.1615816356846;
        Mon, 15 Mar 2021 06:52:36 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id j25sm2681988lfm.25.2021.03.15.06.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 06:52:35 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 282825601CE; Mon, 15 Mar 2021 16:52:35 +0300 (MSK)
Date:   Mon, 15 Mar 2021 16:52:35 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
Message-ID: <YE9mozT+ici7f2ec@grain>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
 <20210315120803.GA13620@redhat.com>
 <YE9ZGl9jlnDz1OBP@grain>
 <20210315131911.GB13620@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315131911.GB13620@redhat.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 02:19:12PM +0100, Oleg Nesterov wrote:
> > >
> > > And why task_lock(current) ? What does it try to protect?
> >
> > As far as I remember this was related to reading from procfs
> > at time the patch was written for first time. Looks like this
> > not relevant anymore and could be dropped.
> 
> I think this was never relevant, ->alloc_lock is per-thread, not per mm.

Then we can safely drop it. I'll take one more look once time permit
and prepare a patch.
