Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2046637F851
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhEMNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhEMNCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620910858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8avfxRzU/986kWMQ/obf9mgRPF8JuzrZEgQAl+41xs8=;
        b=ijUMJk4TZfhqA3wRBEJwimUjJ3GtjGNdnhc2XgGIAopusKZDvITAjxRMS+9X/5f0SYa/9z
        mcHoPyfSXDIU7KN4jnT91I52nm+YW6AqVl5qvDDjCIylnZZ6kRLYQze2euTcqyiXDv9ijS
        c/Vd3VJOn8tZzGPMEzYtEMIyYrfD4DE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-QjVXGVUEP2SQqgIhMKN8uw-1; Thu, 13 May 2021 09:00:55 -0400
X-MC-Unique: QjVXGVUEP2SQqgIhMKN8uw-1
Received: by mail-il1-f197.google.com with SMTP id z3-20020a92cb830000b02901bb45557893so1684711ilo.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 06:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8avfxRzU/986kWMQ/obf9mgRPF8JuzrZEgQAl+41xs8=;
        b=KScIE2UsAi8xL2njyYpTKFAhW1WPKBsg3X1nQWnfDaIfsVoYEmYHkTJ08+PfNs2X7H
         yHKnWduOwGR4kP2EIxbNMuzlEULXrQz/QRCP8IWGLz1KBeGL6bNeHC7q1bDwGCZ74KVb
         dAxhjWhiibWVnw38g1f5vh1bz64fqU0tiaZDD0uYj0LxQesg1ra5RPJLVAVLKXhnh9gI
         1aJ4UHayRmmKc1ILM072ktntLgfvdIwuH1JEbcZ5Yy/0xgiaK0sZL5zP8f12ASvvpphR
         ucZW8WCk9xiIGr/w17YNOs4opiiLTuWlOQHUMH3OFKmJc26Eyx7U1MqY/jSNkvp5wftN
         yD6w==
X-Gm-Message-State: AOAM530YgvfdDEOPTfrnXsTxHhRrnNqXhazyHxj80CLFpWeF8GsZLN3f
        RLq8TIN44gemfv4/9yI5fNEJEMSWy6mVxsws5/PHEoGZ/I/CT6UX/Emq3YUkJXXdsjVd7eox1sE
        LBjtT3FZ7lQqCcVUizzc1IUdO
X-Received: by 2002:a05:6602:21ca:: with SMTP id c10mr1472672ioc.10.1620910853431;
        Thu, 13 May 2021 06:00:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHTMeVsfJA+jGT/0Dw7IyiFQgi3/3sbl7EBXwftmkdA3BBN1KLVpB5eu2a0meQyS6nGkCD1A==
X-Received: by 2002:a05:6602:21ca:: with SMTP id c10mr1472661ioc.10.1620910853269;
        Thu, 13 May 2021 06:00:53 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id t3sm1192745ioi.25.2021.05.13.06.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 06:00:52 -0700 (PDT)
Date:   Thu, 13 May 2021 08:00:50 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] init: Print out unknown kernel parameters
Message-ID: <20210513130050.6czigy6cpz34ovz7@halaneylaptop>
References: <20210511211009.42259-1-ahalaney@redhat.com>
 <cbd3c07e-9dae-44b2-761e-653bd8d0e930@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd3c07e-9dae-44b2-761e-653bd8d0e930@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 04:00:21PM -0700, Randy Dunlap wrote:
> On 5/11/21 2:10 PM, Andrew Halaney wrote:
> > It is easy to foobar setting a kernel parameter on the command line
> > without realizing it, there's not much output that you can use to
> > assess what the kernel did with that parameter by default.
> > 
> > Make it a little more explicit which parameters on the command line
> > _looked_ like a valid parameter for the kernel, but did not match
> > anything and ultimately got tossed to init. This is very similar to the
> > unknown parameter message received when loading a module.
> > 
> > This assumes the parameters are processed in a normal fashion, some
> > parameters (dyndbg= for example) don't register their
> > parameter with the rest of the kernel's parameters, and therefore
> > always show up in this list (and are also given to init - like the
> > rest of this list).
> > 
> > Another example is BOOT_IMAGE= is highlighted as an offender, which it
> > technically is, but is passed by LILO and GRUB so most systems will see
> > that complaint.
> > 
> > An example output where "foobared" and "unrecognized" are intentionally
> > invalid parameters:
> > 
> >   Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.12-dirty debug log_buf_len=4M foobared unrecognized=foo
> >   Unknown command line parameters: foobared BOOT_IMAGE=/boot/vmlinuz-5.12-dirty unrecognized=foo
> 
> Hi Andrew,
> What order is the list of unknown command line parameters listed in?

Hi Randy,

That's a good question considering that they are out of order in my
example output compared to the command line. The order is parameters
without an "=val", then those with an "=val", and within those groups
they should be ordered as they are on the command line.

This is because I'm using the processing work done by
unknown_bootoption(), which stores them in two separate lists to pass to
init later (for arguments and environment). I am "stealing" from those
here:

	for (p = &argv_init[1]; *p; p++)
		end += sprintf(end, " %s", *p);
	for (p = &envp_init[2]; *p; p++)
		end += sprintf(end, " %s", *p);

hence the differing output order from the command line. I didn't
see much value in trying to duplicate that processing logic to get them in
a single list in the order of the command line itself. I debated looking
at the command line and searching each of the offending lists for that
entry to get them in the order of the command line but decided to keep
it simple here since it was achieving what I wanted.

Thanks,
Andrew

