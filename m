Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0461737FA60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhEMPPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhEMPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:15:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9793C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 08:13:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0237D153;
        Thu, 13 May 2021 15:13:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0237D153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620918838; bh=yUkWfvD6KzYNICtBEGq9RvYdbD8TY4h0o9Aiaqw88bg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eeScSRtliJKfYUfBi5jupbdoRde4WsaXSMrYxWVOpZ+st0I7WbspCL22Hef+c99nA
         OOFWokqLi385UCg29HEwzL1ZCyulMCyVr+imhUQbAaa9G6it20CRyexAs9g5TfTj7K
         K+VeB06KlUkn+howheN5a8YMSjxH88sOSGaabafVl/Hvwi5hlAAlAGao2wbWjaXxlJ
         7x0xcZuJZXpeG4T6dibxRzwZu/VbZrTfMc+O/9+2Q6ZO3YVgNJl3cN7+mbnPXfim3j
         jCHYN2UaSk2cPsEbu0qzpR9sUQFgTG3r0JNMv1KchHHJx+7wzop0xb7ICrbuno77xR
         jnkHvzWaE1a8w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <bilbao@vt.edu>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org, tytso@mit.edu,
        rdunlap@infradead.org
Subject: Re: [PATCH v3.1] Fixed typos in all directories of Documentation/ABI/
In-Reply-To: <5710038.lOV4Wx5bFT@iron-maiden>
References: <2219636.ElGaqSPkdT@iron-maiden>
 <20210506185109.1d5ac46d@coco.lan> <11748343.O9o76ZdvQC@iron-maiden>
 <5710038.lOV4Wx5bFT@iron-maiden>
Date:   Thu, 13 May 2021 09:13:57 -0600
Message-ID: <87r1ia7jka.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <bilbao@vt.edu> writes:

> Fix the following typos in the Documentation/ABI/ directory:
>
> - In file obsolete/sysfs-cpuidle, change "obselete" for "obsolete".
>
> - In file removed/sysfs-kernel-uids, change "propotional" for "proportional".
>
> - In directory stable/, fix the following words: "associtated" for "associated",
>   "hexidecimal" for "hexadecimal", "vlue" for "value", "csed" for "caused" and 
>   "wrtie" for "write". This updates a total of five files.
>
> - In directory testing/, fix the following words: "subystem" for "subsystem", 
>   "isochrnous" for "isochronous", "Desctiptors" for "Descriptors", "picutre" for 
>   "picture", "capture" for "capture", "occured" for "ocurred", "connnected" for 
>   "connected","agressively" for "aggressively","manufacturee" for "manufacturer"
>   and "transaction" for "transaction", "malformatted" for "incorrectly formated"
>   ,"internel" for "internal", "writtento" for "written to", "specificed" for 
>   "specified", "beyound" for "beyond", "Symetric" for "Symmetric". This updates
>   a total of eleven files.
>
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied, thanks.

jon
