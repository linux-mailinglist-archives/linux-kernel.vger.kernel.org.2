Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FC9435DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhJUJQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231153AbhJUJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634807672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4QEo41VTsTwWAkmS64CPF5ag+oMVY0ySDObr9iq3wE=;
        b=cPt7/nOi/jILn0vxFLtpffqzTE6YIGEAc58dDUzGHXh+SDs6VTWbyZfsALeCzLiFSPcVRQ
        11dDQJ4mMOfCAQv2n/dmpQentP9wAx3zBtXxc75gE0QbEe/WosEFq0mib33GQpXrpldOl5
        v6/kph/jENQT+9d5NHVXmNTk/5BG3vI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-zzZGvDclMzyDv9vNb6rbSQ-1; Thu, 21 Oct 2021 05:14:31 -0400
X-MC-Unique: zzZGvDclMzyDv9vNb6rbSQ-1
Received: by mail-ed1-f71.google.com with SMTP id f4-20020a50e084000000b003db585bc274so23631449edl.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J4QEo41VTsTwWAkmS64CPF5ag+oMVY0ySDObr9iq3wE=;
        b=a1cBiHKlYJ2wsDvAmV2Y8tecwD+Go+9hc7gMX2CjnyS47YkjSSMgdoYNH0Pc/L3bgl
         jxf85LA/OSove/0/AjG/wZ8MsPq5rcMSVprw99uAgjOWjl1BSdwcB/Wr29tbTRkoAg8v
         Y/uDrlPZDnBU7V3VTLzbDkutvckhJjoJNbK9MH/BbbSUi27FjagR01Sh8FsUJzHeEvY0
         7khk6hRqx3L26UD9zUwuMdiUFKcAGqfnohx8F1JyWYrNrb4u2TVzhweR863YEtV9aQNj
         eIyXT60Trqz1dUu+18hW9p4x89FZxGUabae0t7C7R3sFuzgI2xylPz8uxpvCxJH/KFmP
         elZA==
X-Gm-Message-State: AOAM531ZKk4FN66fEtUQ8yArvrWW4vZy3+ZwhPrhsZXweB8tgpy9w4TZ
        cyLeuwX1VBco5EpLd13KGfI3TjdicHBphdyMCKUhnwnDeBcTcUsSY7HMArR3k4ICAJZtc1LFvfw
        WZrHqoq+VRgEiatRYJBggaZek
X-Received: by 2002:a17:907:6d8b:: with SMTP id sb11mr5936896ejc.332.1634807670513;
        Thu, 21 Oct 2021 02:14:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC4w22ooQ1ELlXofPtV+YK9C8glzgtuKouEL6jVS4Up79AqNqfz7AVbJ0qtlCwjP+TfdczAw==
X-Received: by 2002:a17:907:6d8b:: with SMTP id sb11mr5936875ejc.332.1634807670313;
        Thu, 21 Oct 2021 02:14:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g18sm439733edb.36.2021.10.21.02.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 02:14:29 -0700 (PDT)
Message-ID: <2b5929e2-eb77-d625-5637-fd8353909fda@redhat.com>
Date:   Thu, 21 Oct 2021 11:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     Vadim Pasternak <vadimp@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211021184735.794b22a7@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211021184735.794b22a7@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 10/21/21 09:47, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drivers-x86 tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> Documentation/ABI/stable/sysfs-driver-mlxreg-io:230: WARNING: Unexpected indentation.
> Documentation/ABI/stable/sysfs-driver-mlxreg-io:230: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   527cd54d49dd ("Documentation/ABI: Add new attributes for mlxreg-io sysfs interfaces")

Thank you for reporting this.

I've a bit of a noob question which tool / make target generates these warnings?

I would like to make sure they are fixed, but first I must be able to reproduce
them.

Regards,

Hans

