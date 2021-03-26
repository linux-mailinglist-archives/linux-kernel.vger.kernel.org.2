Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC62534AB93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCZPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:34:16 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44909 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhCZPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:33:59 -0400
Received: by mail-ed1-f43.google.com with SMTP id j3so6747368edp.11;
        Fri, 26 Mar 2021 08:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVuyITToMefSsVdcKHUKULd5V5yD+yduTs+fYSCVCoA=;
        b=iBvkvUNql4vCso3sQzClsmMP16IhO+tkBsv+mLHfkbJXDn4hrg6GgSGHFdMxF67hGe
         kDq9CQrZxRW1peVtsipG8L+x4zy8nKlOwl7EokTCmmrULT8vsqNf+8U4L+Hzm734Cneb
         uvHCMUtzQ4JdeBOgHMs/ioCBhEWtP0ypmd+uiUaMg2V21nIKvATlYtrEooGOipgE1Y2f
         UCV/1/dM2TBhNn5GI50eCmeHrURMPo7pokITIcAMfs+GZO5kBnns7JhLj5NWaQdEMcCY
         jyaZJqi8A1a3sTtTrxqT/5tRmoDXPF3Y+WG6M1q66cmjZyk9Zb6l6TLCcgjGQ0hGXRfp
         Pl+A==
X-Gm-Message-State: AOAM530XdvKuKKGZE3I82TTBMbQ29a6H0OEVTcivT8cpU5Rx1853p9LG
        Bh9SwprApVkun9BR80JRHBGSUy87MPvKPGMWRj0O+0pw
X-Google-Smtp-Source: ABdhPJxSkedp8fuIQnTqBygp92MCs6xp3cWITyw3O2utH0HrpIqiVIMyxLv1UpSZKeKtgdfkbJ7ovzgI1X1OBtDclns=
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr15796150edc.94.1616772838554;
 Fri, 26 Mar 2021 08:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com> <CALCETrWOc7wwW=KY2dGJGy9k5Ag=KhkdGGTDZMvgRHgyQ5fDjQ@mail.gmail.com>
In-Reply-To: <CALCETrWOc7wwW=KY2dGJGy9k5Ag=KhkdGGTDZMvgRHgyQ5fDjQ@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 26 Mar 2021 11:33:47 -0400
Message-ID: <CAJvTdK=OGALDso0H+asjgkjD_VaPNZzm+LpV+msM_i5aVUm_qw@mail.gmail.com>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 9:42 PM Andy Lutomirski <luto@kernel.org> wrote:

> Regardless of what you call AMX, AMX requires kernel enabling.

I submit, that after the generic XFD support is in place,
there is exactly 1 bit that needs to be flipped to enable
user applications to benefit from AMX.

I submit the patch that knows about AMX and double checks the
state size is superfluous.

I submit that updating /proc/cpuinfo is superfluous.

What AMX-specific kernel enabling did I miss?

> Specifically, it appears that leaving AMX in use in the XINUSE sense
> degrades system performance and/or power.

Please share the specifics about what performance or power issue you anticipate.

thanks,
-Len
