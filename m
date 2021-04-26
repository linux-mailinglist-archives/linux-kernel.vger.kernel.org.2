Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68C436B4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhDZOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhDZOgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:36:45 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F256C061756;
        Mon, 26 Apr 2021 07:36:02 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id g9-20020a4ad3090000b02901ec6daba49aso5504475oos.6;
        Mon, 26 Apr 2021 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1uvxZJv7NEH6OlB0CPMKpMb7Akfa13bCI4rzIGoVg9Q=;
        b=Zyfy0F0wkpJKZ9NeMFQOcMIoCxL1+3xCAMMZGPv2+Q/bj3I0wih25Z5tYK9a8heIrz
         zAu/Tn0ZoRs/U8XkmjosQ+5kaTcHc+zBa7f3C9QsM/LM8opUePa0Ul2wCabc33tD1dkX
         LOmjrozfLmoXm8yJfXTuaC5V5Au80KUeeU2ReZRT+NBH4LdLsT1/EROnDfNIn5hLabSf
         66swUVuvEJiZTDpcgqKijo1aaPhDRAVAXTmAFmoeQYj4x0sGGkjs0ejQj4AKKYpXYh9d
         adq/VzHKxq1a8D4CwVA6Zf13sSIvE2aBzrKgCmvhR32iTgTvcB+HTW0QLQ6XE3OAetEj
         UYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1uvxZJv7NEH6OlB0CPMKpMb7Akfa13bCI4rzIGoVg9Q=;
        b=VxKQMlamO5tRlceAu7y+OajjJ61kJC3UveBxyWpx6hkjKFdmM0x6KFIEnH1C+1TI+3
         92+lvLou8HtAW9wlwJJc+yCPddfs7lOOq9zACM3/5hwui+Fj7XuFMxZYgjj9yXKtRUQg
         WeCV6XF0JEafiUIZldLYyidhskx9Ct1gJEeef5+ZDPctuSptHsI8sIBXnx8F/8tf1Pjz
         f8S6ZC+sXInANNYHaVmhYIp6MATehOsV0b46UhfEECvG4LfmhIqIaKE61o2ZyrzHQh48
         8VwF5kfwxk32AjCXMpG8ylBaSuG0Tyo0XpejGrQWau5RKClMJpmyV9cwvwzE93sV2Kdx
         Wj1Q==
X-Gm-Message-State: AOAM531fceAV3w3h+Ck2gB4Q/44O/DXptWfedjTmXMq0FGm75IjLXSoz
        w6CeM9S0lLKF72EEtHqURPM=
X-Google-Smtp-Source: ABdhPJy7RjGcfngqk5ns+IfAM26Ogp7/MMZ/3lERy+T3yGgBoyPYs6ERPRB/mA0KfpXBBpv26ocpMA==
X-Received: by 2002:a4a:3142:: with SMTP id v2mr13599985oog.9.1619447761416;
        Mon, 26 Apr 2021 07:36:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r9sm3479054otn.64.2021.04.26.07.36.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Apr 2021 07:36:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Apr 2021 07:35:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] hwmon: (max31790) Rework to use regmap
Message-ID: <20210426143559.GA112486@roeck-us.net>
References: <20210413025948.901867-1-kubernat@cesnet.cz>
 <250c1c16-541a-984f-c720-1a8b6176e97e@roeck-us.net>
 <CABKa3npjrpq5Aw_Xqy3mFZtUHZcfB0YENxEDgo_MCwPUKqA4ww@mail.gmail.com>
 <20210426141745.GA257701@roeck-us.net>
 <CABKa3np=osah3zcNmwohL0h8sVOHYcGW6rNYhM=1OzrOiLo50A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABKa3np=osah3zcNmwohL0h8sVOHYcGW6rNYhM=1OzrOiLo50A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 04:29:55PM +0200, Václav Kubernát wrote:
> po 26. 4. 2021 v 16:18 odesílatel Guenter Roeck <linux@roeck-us.net> napsal:
> >
> > On Mon, Apr 26, 2021 at 02:46:27PM +0200, Václav Kubernát wrote:
> > > Hello.
> > >
> > > I'm sending a new version of my patch on max31790. This new version
> > > fixes the cache issue and actually makes it work by setting
> > > .cache_type. You were right about the "yes/no" ranges, so I flipped
> > > those.
> > >
> > > By the way, it seems that the reason your reply got lost is because of
> > > weird addresses in the "Cc:" email field, they end with "cesnet.cz",
> > > so it could be that I'm sending email incorrectly. Let me know if I'm
> > > doing something wrong.
> > >
> >
> > Yes, the To: field of your series is either empty (for the first patch
> > of the series), or it is something like:
> >         To: unlisted-recipients: no To-header on input <;
> >
> > Also, you send your follow-up series as response of the previous series
> > which doesn't follow the guidance for submitting patches and may result
> > in the entire series getting lost.
> >
> 
> Sorry, I will fix my email-sending procedure. Should I resend the
> patch series without the In-Reply-To field?
> 
No, just keep it in mind for next time.

Thanks,
Guenter
