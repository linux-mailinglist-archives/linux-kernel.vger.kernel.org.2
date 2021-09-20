Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6BD411683
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhITOOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:14:10 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:44830 "EHLO mail.acc.umu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235223AbhITOOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:14:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by amavisd-new (Postfix) with ESMTP id 10E6144B91;
        Mon, 20 Sep 2021 16:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=acc.umu.se; s=mail1;
        t=1632147152; bh=yR5l/oUZjaR0mgSFYnnmAeCKkRwVCyA2exwEIo5ycR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9O1o2XAJJQn4QNkyyqzFCn6qre0apqDfGqKC2eWjD9IosukH0WT6Vvu0HDOAEvY3
         k5Yg85mWIwKheFgi/6+LYvIdL7stSHPOebMB+NW4qjEFWScWqK+kpCA/RUb0jz5L4D
         Xtl1cLDr22BIJ3Chsm8HSbtDKnn1TqgprUB1xAuje89WIdRatZRYn2oQ4yhUavHyce
         46sZy1Ed3xdocUW0aJD/mdXdmPN/3ZgpgcivRmnmCnen0VDh/YpO761zoRJfPRnKiQ
         s/5k2Lr5clMeWz40Vf1RJ0pUUPLAK7uReKRYLR+WfKdMLUBcDi5FyqUBe7WoA+HxhX
         vrtS3sFyFYzHg==
Received: by mail.acc.umu.se (Postfix, from userid 24471)
        id 9934A44B92; Mon, 20 Sep 2021 16:12:31 +0200 (CEST)
Date:   Mon, 20 Sep 2021 16:12:31 +0200
From:   Anton Lundin <glance@acc.umu.se>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Openipmi-developer] Issue with panic handling and ipmi
Message-ID: <20210920141231.GH108031@montezuma.acc.umu.se>
References: <20210916145300.GD108031@montezuma.acc.umu.se>
 <20210916163945.GY545073@minyard.net>
 <20210917101419.GE108031@montezuma.acc.umu.se>
 <20210917120758.GA545073@minyard.net>
 <20210917125525.GF108031@montezuma.acc.umu.se>
 <20210917131916.GB545073@minyard.net>
 <20210917132648.GG108031@montezuma.acc.umu.se>
 <20210920113802.GC545073@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210920113802.GC545073@minyard.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 September, 2021 - Corey Minyard wrote:

> Well, that was dumb.  Fix follows...
> 
> Thanks for working on this.  On your approval, I'll send this to Linus.

Winner winner chicken dinner!

This fixes the issue, and now panic timer works, and we get crashdumps
to pstore.

Great job, I approve!


Thanks for your help getting this fixed.


//Anton
