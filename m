Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E3E30EFE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhBDJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:45:20 -0500
Received: from mx2.veeam.com ([64.129.123.6]:45208 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233597AbhBDJpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:45:19 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id BE54142313;
        Thu,  4 Feb 2021 04:44:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1612431875; bh=8Q+YRaTK8pSGQxUE+Di9toxMhCZgzNBGr9VcCbi5JH4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=bjPq9Eh71wsDjK0/o0k4Re55zJLzZczHy1adnsBKzVl5Kmpp4i2A+j79DI5lNaDDZ
         OEaZSr6LkatPl8ukXlQ31u6dqbzQIsZZTsPll+ed7x4hQ43d5tNuuS7kkzJohBoOhp
         4H1QiedztvMeDxgA4zjzn5hhMZL6ZvYN9j1pnRRs=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 4 Feb 2021
 10:44:32 +0100
Date:   Thu, 4 Feb 2021 12:44:27 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "jack@suse.cz" <jack@suse.cz>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pavgel.tide@veeam.com" <pavgel.tide@veeam.com>
Subject: Re: [PATCH v4 1/6] docs: device-mapper: add remap_and_filter
Message-ID: <20210204094427.GA4325@veeam.com>
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
 <1612367638-3794-2-git-send-email-sergei.shtepa@veeam.com>
 <ef604ad7-1348-1ffa-e3c4-67d153620e08@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ef604ad7-1348-1ffa-e3c4-67d153620e08@infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26566706A
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, I'll fix it all.

-- 
Sergei Shtepa
Veeam Software developer.
