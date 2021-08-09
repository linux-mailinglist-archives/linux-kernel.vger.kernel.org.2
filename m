Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8F3E451E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhHIL52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:57:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39254 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhHIL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:57:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 288C621A5C;
        Mon,  9 Aug 2021 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628510226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Uo1PVFrRAL506VNbpSo7f29ooxv/mPgKIZzf0LxTos=;
        b=S3sO437/zolHdJ1Hy2vdaKB4qssfAIwLgsub3mkYtC6PFZwDOmV+eHWQTixfNNWYWj3RKc
        hci9HU2SaFv7E98ePxmioIx6fn2WezV+M45o0f1ABoFah6ceO81/uweWCnQwhpdoK7gdY4
        F4ASHkWVnkopzm4baohuE37+x7cKAD4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BF0D7A3B81;
        Mon,  9 Aug 2021 11:57:05 +0000 (UTC)
Date:   Mon, 9 Aug 2021 13:57:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     akpm@linux-foundation.org, chenguanyou@xiaomi.com,
        gpiccoli@canonical.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        vbabka@suse.cz
Subject: Re: [PATCH v2] hungtask: add filter kthread
Message-ID: <YREYEewURDEFf/7y@dhcp22.suse.cz>
References: <YRDyquuwshpHNdz0@dhcp22.suse.cz>
 <20210809115238.4044-1-chenguanyou@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809115238.4044-1-chenguanyou@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-08-21 19:52:38, chenguanyou wrote:
> > This still suggests that the primary purpose of the interface is to
> > paper over real problems that should be fixed instead.
> 
> I know, but i don't care kernel threads state because of it doesn't neet to fixed.
> The API only for debugging.

Then I am afraid you have to keep this a local non-upstream feature in
your kernel. This doesn't look like an upstream material to me.
-- 
Michal Hocko
SUSE Labs
