Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C273E23C6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbhHFHMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:12:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48398 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbhHFHMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:12:39 -0400
Date:   Fri, 6 Aug 2021 09:12:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628233942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uztufeXIPlpFJaFAF4eebtQDVgAvKrPhLRO4SCbarbQ=;
        b=vJ9iUb8r1i85Yk3u6GTgJWfOnJk9vzTr6jF8QZF46/L8EK4pQAedoYZbiEPNVdydmEogvp
        8ni39ylAdFDu4wFRqucS+nM0ClRpNOUUrWk+KYilUPw3h3Udy6QqDGNYUO437qf43ZHvwr
        I1tohhoM6u1K/ckx3EwNIV+j4coFniefQK+EQARozLStuw11XdLw82hbfzAqAfel91tGQK
        iTi5ZAQS4qdCdiPhnPgtvA8EoKlRVEVYLUkr6rQLU6W2+3vNlIJkIk+WKThO+7rMy7IwkG
        jOkNZ5CDRL2qQVrEx/8Y57n+EUtHcj7wP9QuWajqN455cR7unOw1kgJ2t1MFxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628233942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uztufeXIPlpFJaFAF4eebtQDVgAvKrPhLRO4SCbarbQ=;
        b=huDxugXVJ7V8R84eQ8uTdNu5jSl8Ur5mrH1FhW5TIy2F/lDOMz3dQifFjCmiSsur+J9mm1
        nkE9Jf6miCiRWJBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [linux-rt-devel:linux-5.13.y-rt-testing 204/232]
 kernel/locking/spinlock_rt.c:244:13: warning: no previous prototype for
 'rt_rwlock_is_contended'
Message-ID: <20210806071221.h7nvwrry6tmscvzf@linutronix.de>
References: <202108061305.tWe3eTtc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202108061305.tWe3eTtc-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-06 13:32:14 [+0800], kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.13.y-rt-testing
> head:   ef625e4b904469d3c5d6962b36abaed37f49db62
> commit: 4d507329b3b9318f8fddbc1508ce38d324b3325a [204/232] x86: Enable RT also on 32bit

I just removed that branch. It is outdated and not going to be updated.

Sebastian
