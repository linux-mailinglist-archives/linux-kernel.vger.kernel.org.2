Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8BD3B47EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhFYRCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:02:41 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:44832 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbhFYRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:02:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D07041280C63;
        Fri, 25 Jun 2021 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1624640416;
        bh=7UQfTm0gZW2yxFLwp3168eDhzZoKMAzyPjTiPK+nGB0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Sl3wwCAdv6zxpH0eBfheb/7EAwxeLMTNYjArvJ40vmBkHP4Zc9mK65A/9DrWVoLQA
         X42K0DJSAZZdxG0OkRKgNz2u8/ecaZjsQzQ2FZ2ZWAkw0Iu7aCDZ3obApi/I0+twYo
         d5hvVcpy0xL24/XJ+tSUYibMSd3mrpIX6YuvZDZc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6vGj3iDrFs_2; Fri, 25 Jun 2021 10:00:16 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7AA061280B27;
        Fri, 25 Jun 2021 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1624640416;
        bh=7UQfTm0gZW2yxFLwp3168eDhzZoKMAzyPjTiPK+nGB0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Sl3wwCAdv6zxpH0eBfheb/7EAwxeLMTNYjArvJ40vmBkHP4Zc9mK65A/9DrWVoLQA
         X42K0DJSAZZdxG0OkRKgNz2u8/ecaZjsQzQ2FZ2ZWAkw0Iu7aCDZ3obApi/I0+twYo
         d5hvVcpy0xL24/XJ+tSUYibMSd3mrpIX6YuvZDZc=
Message-ID: <214c41fae1f1b148e5b04a58c1b018fb091d7e83.camel@HansenPartnership.com>
Subject: Re: linux-mm@kvack.org - limping on a backup
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Benjamin LaHaise <ben@communityfibre.ca>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Jun 2021 10:00:15 -0700
In-Reply-To: <20210622145954.GA4058@kvack.org>
References: <20210622145954.GA4058@kvack.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-06-22 at 10:59 -0400, Benjamin LaHaise wrote:
> FYI: the filesystem hosting kanga.kvack.org which hosts 
> linux-mm@kvack.org
> and a few other assorted things was damaged around 9:17am.  The
> mailing list is back up and running from a March 2nd backup for
> now.  The problem is either a bad SSD or a btrfs bug, however no
> crash dump was captured to help with debugging.  New hardware will be
> deployed this afternoon after an attempt at data recovery is made.

Perhaps it's time to move this list over to vger or the linux.dev
infrastructure now that it's being brought up?  We already migrated the
containers list without too much pain.

Regards,

James


