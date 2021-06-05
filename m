Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2670D39C645
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFEG20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:28:26 -0400
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:46536 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229726AbhFEG2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:28:25 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8A31A1802912D;
        Sat,  5 Jun 2021 06:26:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 98C4C315D74;
        Sat,  5 Jun 2021 06:26:36 +0000 (UTC)
Message-ID: <eab0487d7b4e68badbbe0505b2a7903b9d8931c4.camel@perches.com>
Subject: Re: [PATCH] docs: checkpatch: Document and segregate more
 checkpatch message types
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>, corbet@lwn.net,
        lukas.bulwahn@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Jun 2021 23:26:35 -0700
In-Reply-To: <20210605055932.18393-1-dwaipayanray1@gmail.com>
References: <20210605055932.18393-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.90
X-Stat-Signature: hmh3oriay35e4o3hn3mjeph7fncoca7a
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 98C4C315D74
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/gd7cuwJi9uVQjoxeLfP2WzppMLdcGsO0=
X-HE-Tag: 1622874396-207889
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-06-05 at 11:29 +0530, Dwaipayan Ray wrote:
> Add and document more checkpatch message types. About 50% of all
> message types are documented now.
[]
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
[]
> +  **DEVICE_ATTR_FUNCTIONS**
> +    The function names used in DEVICE_ATTR is unusual.
> +    Typically, the store and show functions are named as name_store and
> +    name_show, where name is the device name.

No, it's the variable name of an attribute of a device, not the device name.

    Typically, the store and show functions are used with <attr>_store and
    <attr>_show, where <attr> is a named attribute variable of the device.

> +    Consider the following examples::
> +
> +      static DEVICE_ATTR(type, 0444, type_show, NULL);
> +      static DEVICE_ATTR(power, 0644, power_show, power_store);
> +
> +    The function names should preferably follow the above pattern.
> +
> +    See: https://www.kernel.org/doc/html/latest/driver-api/driver-model/device.html#attributes
> +
> +  **DEVICE_ATTR_RO**
> +    The DEVICE_ATTR_RO(name) helper macro can be used in place of
> +    DEVICE_ATTR(name, 0444, name_show, NULL);
> +
> +    Note that the macro automatically appends _show to the device name
> +    for the show method.

attribute, etc...

> +  **ENOSYS**
> +    ENOSYS means that a nonexistent system call was called.  We have a
> +    bad habit of using it for things like invalid operations on
> +    otherwise valid syscalls.  This should be avoided in new code.

Please do not use terms like "we".  Just use passive voice and not
any first person/collective words.

> +
> +    See: https://lore.kernel.org/lkml/5eb299021dec23c1a48fa7d9f2c8b794e967766d.1408730669.git.luto@amacapital.net/
> +
> +  **ENOTSUPP**
> +    ENOTSUPP is not a standard error code and should be avoided in new patches.
> +    EOPNOTSUPP should be used instead.

Better word choice is like this section above.


