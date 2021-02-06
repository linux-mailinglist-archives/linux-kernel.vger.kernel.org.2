Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7751C311EF6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhBFQ6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 11:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBFQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 11:58:35 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4914AC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 08:57:54 -0800 (PST)
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id DA12197779C;
        Sat,  6 Feb 2021 17:57:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1612630664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KO7txrTNMrXL9dyV4Zdy7dReAFiLFbtsqwh0kVi7vQc=;
        b=ruerzVwdeyIaCc6pOzr51a4IueZp796FInE0hUAI4Z400o5qgJVgCohIPJILta4+mdw8Kl
        /YKtdDjhgsNXcd8pCKRM96410E60etkNGEQaJNq3JV/5uPo2eutFecZWaT+C5EZQEKOAdA
        IAXSnyKtBjyT/JZS9VbJch4l7A6a3bI=
Date:   Sat, 6 Feb 2021 17:57:44 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Hanabishi Recca <irecca.kun@gmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, aaptel@suse.com,
        andy.lavr@gmail.com, anton@tuxera.com, dan.carpenter@oracle.com,
        dsterba@suse.cz, ebiggers@kernel.org, hch@lst.de, joe@perches.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, mark@harmstone.com,
        nborisov@suse.com, pali@kernel.org, rdunlap@infradead.org,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v20 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20210206165744.q6sjcujezxg3ho2z@spock.localdomain>
References: <CAOehnrO-qjA4-YbqjyQCc27SyE_T2_bPRfWNg=jb8_tTetRUkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOehnrO-qjA4-YbqjyQCc27SyE_T2_bPRfWNg=jb8_tTetRUkw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 01:43:10AM +0500, Hanabishi Recca wrote:
> Can't even build v20 due to compilation errors.

Try this please: http://ix.io/2OwR

-- 
  Oleksandr Natalenko (post-factum)
