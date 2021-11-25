Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CF445E1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357173AbhKYUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357110AbhKYUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:33:56 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0938FC0613FE;
        Thu, 25 Nov 2021 12:28:45 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id r2so6871347ilb.10;
        Thu, 25 Nov 2021 12:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UF7bxqoO6JrinwXL/4rYhg/6TjsTgpExSTTC8wwpd14=;
        b=jjPUG07lcm8r0SVY8pTw+HsMRN23h+L6+1/PBDQbdUB3JWOfptDHzV1RpbSsqLEsN+
         eit+NR8VaoD607F7EhOne7kL80ov2OYQMoqfgH+z6GYIdv+sEqsvWZ6TJUVxPrvEglj4
         TFrMnp0Pio1+vEKJJ+/pkVJPkCx8VT7VUxJqBzWUOZJKocNccZ1NHJvpjcQeHMozYzjM
         6397czk/OsJVZbpx/VTwES3gIhDvyJRyhrMAWJqBo/E3TAeydJhx//XhuidotbuQWbN6
         jotlywgZr2+nRCbVG2hMV4FtsSyW33RT4O+5WjAQXtvHoX+Q/0EzDCs42ReY8bOM+gSV
         7qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UF7bxqoO6JrinwXL/4rYhg/6TjsTgpExSTTC8wwpd14=;
        b=dt6fh+k2DG2/ktFvXNOzhpNZu6JfEccTgxBJLEuVwvE9AWqI1QpULJQPjSvjbJsmFL
         Y6hTkE5dkDA1f+hCVwkX3B6pOsYRaBZjpSp1orXUT1FVlli5juryV2sUiosMTzWYt5TO
         FlkVKQSQwhy6/LzovDXCa3neOkoSAaL7w/xEazEkQmERKXei3YYMe4p4WELG29D8U2Dk
         vyyttrlvDljeoSaTOpxfTQp+zYm8wcScx9Wm29NMgzHiafWdB3sc+5PFyWDvh9uMPT9W
         5dYJnTmW9I71gv+Zov7sPs5Q7Xy05Tl9iN5mywpnhHEGRxwTFvfrHJBrYuo/rACfJpmh
         gTxA==
X-Gm-Message-State: AOAM530YgXYTb0pnd0DB2xz1VCoDdXB0GfsiQXQQLIREbMbqbNxrwj+D
        g2AevNpq0g5HHeKMLhahAfrHeQn1GI+XuSiB+0m0GtE1p3Y=
X-Google-Smtp-Source: ABdhPJx4tcbk5X+2a/nX1SM+1HJL9uzlnRHnexBIzCpOdSCLIqVsGQJ/+UIuGWShZ/b+Jt99SrrTaHYeah8a3YceG8I=
X-Received: by 2002:a05:6e02:106c:: with SMTP id q12mr22335434ilj.125.1637872124495;
 Thu, 25 Nov 2021 12:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
 <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
 <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
 <CAB95QAT_b8Wef+4wN-H8dKZXxgnznqOk5J0fMuL2XJLhob7d9Q@mail.gmail.com>
 <b7616187-87d8-c87f-8f66-d5936a33395f@roeck-us.net> <CAB95QAQ2vpXFxZC0G6ogbpk+rDzGMN7N8-RaUX9w_U5bQ1WGMg@mail.gmail.com>
 <CAHp75Vdi8ujoC5LTYqNmiWe1dTxrYRQKS+YtZE921d-6CZTs=A@mail.gmail.com>
In-Reply-To: <CAHp75Vdi8ujoC5LTYqNmiWe1dTxrYRQKS+YtZE921d-6CZTs=A@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 25 Nov 2021 21:28:33 +0100
Message-ID: <CAB95QAS_Cafc5uy7auH+Z05rrBLNFZqhZRJ_cwn8OFRfpe44mA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 at 21:10, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Since you are talking about something which is not ready yet (as I
> read "will" above), I propose a compromise variant, i.e. let's leave
> current driver(s) as is for v5.17 and after v5.17-rc1 you submit your
> proposal for review. Okay?
>

Andy, I'm pretty sure the submission will happen and my only intention
is to save possible users from driver name change right after the
driver is introduced. I see no harm in renaming it.

Eugene
