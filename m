Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574BA3DB03A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 02:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhG3AW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 20:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbhG3AW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:22:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2969CC061765;
        Thu, 29 Jul 2021 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tE/KgBIHE9thkmJ6RceOo7MQucdTlt7o/ncInkLoM0s=; b=Rt7Lk9i7wK7Q2lEvlOM/zMRLea
        4+D0GEek1DofZzx01P1tB7QUFIZCkHct5JwYRRtFD9Mk5XWSyfSZgq9YYo08PRpALXIlxj1EYVo7A
        eDfrTwhnv3GLY9XPPQdns8H1hwcjTOuHaC97LzygTeZDlrQzdCJBDN+rA80yGf7+1KaXd7/Zlxjmk
        57OxFUXUIFW6NHPoASua3nTH99BXWuSmgjlTnapvndTjzRTm8uusq0W52gbnJ/Fq0xO2MxP2DZMng
        oRqn+I84MdcpFcYIviEmBfagPaqrCVInjitUFQLRfubUAGWaS2CQj52Vtr5XSAMC6WNNlO3YfBhEj
        p2g79j0Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9GIc-006Vgq-T1; Fri, 30 Jul 2021 00:22:50 +0000
Date:   Thu, 29 Jul 2021 17:22:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] common/module: add a patient module rmmod
Message-ID: <YQNGWqqIHKNRugcE@bombadil.infradead.org>
References: <20210727201045.2540681-1-mcgrof@kernel.org>
 <20210727201045.2540681-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727201045.2540681-4-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 01:10:44PM -0700, Luis Chamberlain wrote:
> Furthermore... experience on older kernels shows it may be a while
> before we can actually remove the module even *after*
> /sys/module/$module/refcnt is 0. This is only currently observed
> on older kernels.

Sadly this is incorrect, after running a test without any sleep
once refcnt is 0 also fails on linux-next, just that the failure rate
is much lower, at about ~ 1/1642.

So the sleep is still relevant even if testing with linux-next.

  Luis
