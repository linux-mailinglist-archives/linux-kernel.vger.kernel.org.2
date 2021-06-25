Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525123B4936
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFYTXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 15:23:50 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:35026 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhFYTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:23:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 71526128047C;
        Fri, 25 Jun 2021 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1624648885;
        bh=8XIuY1a6FoG/SQyGu0eB39s4CV1XNzvWJrFBhG1YpKI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Q6doCv2XJKad0r0TQTpEt3L5i8gmAUIUzaB+U6ZehDool0jZFu3CFODcKJW0dBCJN
         oKYPc3SBysvWbXUwSV/b1Fvm3iHZ/+ynGPlskee7WHyxHW3BEcAh17BHPaq7yD/y5C
         +oZnwWLCApvlWkEEu9ocRSn4b1XcC9kPFrjI4gw8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gESPPNXjyJ7z; Fri, 25 Jun 2021 12:21:25 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 13F011280478;
        Fri, 25 Jun 2021 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1624648885;
        bh=8XIuY1a6FoG/SQyGu0eB39s4CV1XNzvWJrFBhG1YpKI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Q6doCv2XJKad0r0TQTpEt3L5i8gmAUIUzaB+U6ZehDool0jZFu3CFODcKJW0dBCJN
         oKYPc3SBysvWbXUwSV/b1Fvm3iHZ/+ynGPlskee7WHyxHW3BEcAh17BHPaq7yD/y5C
         +oZnwWLCApvlWkEEu9ocRSn4b1XcC9kPFrjI4gw8=
Message-ID: <6f309c63f5b7be968ae679e81ab959db05681e8a.camel@HansenPartnership.com>
Subject: Re: linux-mm@kvack.org - limping on a backup
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Benjamin LaHaise <ben@communityfibre.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Jun 2021 12:21:24 -0700
In-Reply-To: <20210625171259.GG4058@kvack.org>
References: <20210622145954.GA4058@kvack.org>
         <214c41fae1f1b148e5b04a58c1b018fb091d7e83.camel@HansenPartnership.com>
         <20210625171259.GG4058@kvack.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-25 at 13:12 -0400, Benjamin LaHaise wrote:
> On Fri, Jun 25, 2021 at 10:00:15AM -0700, James Bottomley wrote:
> > Perhaps it's time to move this list over to vger or the linux.dev
> > infrastructure now that it's being brought up?  We already migrated
> > the containers list without too much pain.
> 
> Maybe the btrfs bugs should get fixed.

I believe we can do both.

James


