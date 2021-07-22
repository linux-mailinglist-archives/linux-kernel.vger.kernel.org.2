Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69DD3D1E36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGVFo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:44:56 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:60736
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229987AbhGVFoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=XkGqOg5Za4ENKBDhG5J4S+kQE8dYJ4AbT6Qv
        h1GWXTE=; b=KkDPwLy2NO/sEKlClRaBVDaWKlEPz75KxCv3w47EokcdeuMK+Sqd
        z9hTi6eVEm2O3m+6iP5lc/to40AZFpDi5+GspJZBhY8e3/1Wl0PQCWe4sh1o6caL
        l+MQmlj8lg/GnWZRyd3jRnP8b/0jwDMIOIxjBX2nfEbrhMRTnveC+lA=
Received: by ajax-webmail-app1 (Coremail) ; Thu, 22 Jul 2021 14:25:18 +0800
 (GMT+08:00)
X-Originating-IP: [10.162.86.133]
Date:   Thu, 22 Jul 2021 14:25:18 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Xiyu Yang" <19210240158@fudan.edu.cn>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Tejun Heo" <tj@kernel.org>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, "Xin Tan" <tanxin.ctf@gmail.com>
Subject: Re: Re: [PATCH] kernfs: Convert from atomic_t to refcount_t on
 kernfs_node->count
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20200917(8294e55f) Copyright (c) 2002-2021 www.mailtech.cn fudan.edu.cn
In-Reply-To: <YPkHAX1YdmxZtW49@kroah.com>
References: <60f8506d.1c69fb81.d8d4d.3bceSMTPIN_ADDED_BROKEN@mx.google.com>
 <YPkHAX1YdmxZtW49@kroah.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: 7bit
X-CM-CTRLDATA: 59SozWZvb3Rlcl90eHQ9ODA3OjEw
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <350c2c44.5a22.17acce3c8f4.Coremail.19210240158@fudan.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: XAUFCgAX+mpOD_lg4y2mAA--.15487W
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/1tbiAQ4KAVKp4xXqNwABsV
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I'm not sure why failed... I send it again now.

I consider it as a reference count due to its related operations and the developer's comments, such as "put a reference count on a kernfs_node" around the kernfs_put(). 
If anything wrong, please let me know.
Thanks.

> -----Original Messages-----
> From: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> Sent Time: 2021-07-22 13:49:53 (Thursday)
> To: "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>
> Cc: "Tejun Heo" <tj@kernel.org>, linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, "Xin Tan" <tanxin.ctf@gmail.com>
> Subject: Re: [PATCH] kernfs: Convert from atomic_t to refcount_t on kernfs_node->count
> 
> On Thu, Jul 22, 2021 at 12:50:34AM +0800, xiyuyang19@fudan.edu.cn wrote:
> 
> You sent an empty reply???






