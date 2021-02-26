Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3016325BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 04:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBZD1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 22:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZD1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 22:27:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04928C06174A;
        Thu, 25 Feb 2021 19:26:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b15so5199844pjb.0;
        Thu, 25 Feb 2021 19:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=78pTGGTVx/VDUeMbmDair/QeL261AqryHviFTtBRyxQ=;
        b=lzD5E2Oep+L+vhd/Q/RENatwuCz++QZ0QwHAhUFQuN+h247ey8hI2Ip3V32+HYHDWG
         AVADNEmksL6cd5g0x0wgXYkdDBD5g7JrDg8btmO2a3rNaVEUxXqTF38/XgYUMQnc1h6F
         i/vsAz0n7XkxZx/1x83xCSBpkZTS8JhKfkgjnY1qwY2p9maP5gug2S2mxZmIeWuqF7zi
         c3NZpbCMpGTbHvJratl4DojAjMf3wcbc74dQ3sYTDTAlMIThl7k02umgA4Aa56MVsfJf
         qFofPk+NUwJONgTiWwWs7OfALK5WwmhdEz6GMJlBI2J+wuhrDchRU/lkdr8rqHfCbC9n
         aV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=78pTGGTVx/VDUeMbmDair/QeL261AqryHviFTtBRyxQ=;
        b=qpZLdBlJJ8jPSh9oz/jhPh7QEzw+1+wK5tSeiZ/teCL7oP0UXM2nPKcpUtMYzb8DZs
         fvo4JUaupQaj/QSrOerMgfQ3LnzwxNBTWUUcHpXUNo3MQL61MrRKTuli3TF/IGkfwRoW
         WcSlwf98VCsGuc4UbjELcv1qIGMO5pd5X7HEmSZPWEMeXTKzI/7YIjW3gr+8EQvlqCqX
         7casv+MCawdYRzuo23ypLIe8kd3vp1MG/9LxG+e5ujS+CdtPIyYGgpPC8q1BQamnfv/3
         aEc+364FBzeguRLXboGpBwONdXcq9fB6MqtRSLk8ichPI74SuJng6AXC/v2H54K9wnz2
         +dlw==
X-Gm-Message-State: AOAM533n0BQ6lImYe1V8xabxQSY3pqVNppiuS2FUJFOf78VgL+HiUDQs
        om3B4EVtGF8tWp+8rMHVuudP8nBheVg1TmVta0Q=
X-Google-Smtp-Source: ABdhPJzPoyARR7hP06SshIwTt+qf4VOctmLs1N1tfwpTWEpldqn4+rEfXELdgPxKpjR9PICNZJSyoZ2ZcqZHSdsg0To=
X-Received: by 2002:a17:90a:cb12:: with SMTP id z18mr1186334pjt.163.1614310018579;
 Thu, 25 Feb 2021 19:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20210224151619.67c29731@alex-virtual-machine> <20210224103105.GA16368@linux>
 <20210225114329.4e1a41c6@alex-virtual-machine> <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
 <20210225113930.GA7227@localhost.localdomain> <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
 <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com> <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Thu, 25 Feb 2021 19:26:47 -0800
Message-ID: <CA+8MBbKtEuDb3XSNnQFNHOxOS4x=LNrxvCgvBH1yuLK72Ab_CA@mail.gmail.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Aili Yao <yaoaili@kingsoft.com>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "inux-edac@vger.kernel.org" <inux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 6:23 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Thu, Feb 25, 2021 at 10:15:42AM -0800, Luck, Tony wrote:

> > CPU3 reads the poison and starts along same path that CPU2
> > did.
>
> I think that the MCE loop happening on CPU2 and CPU3 is unexpected
> and these threads should immediately kill the current process on
> each CPU.  force_sig_mceerr() in kill_me_maybe() is supposed to do it,
> so Aili's patch would fix this issue too?

It would stop the looping. But for the case where the error came from
user code we don't have
the virtual address that was accessed at this point (normally this
address is found during the
reverse lokup from the physical address inside memory_failure()).

So we can send a generic SIGBUS, but not one with the usual extra
information about the
location of the error.

-Tony
