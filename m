Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C23580F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhDHKjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhDHKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:39:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A4FC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 03:38:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p22so949177wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 03:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRaMcxz3zgFPYNGt7SjAbzHOcdHXj9ZgSC7Zn81PL2M=;
        b=DLhUR7rooHo2v1rKHmhVq8DM4VON7DuPXveOFVk80ZcGMyTsiP7rsIMtH1/nLDX8FP
         QmPygjaYOziMZBitOI3Uyq9WRsaAmG6l73GzWgAeeWb+/OUSbyHWQXaxyDD3R1bA4j5l
         u+DtvAa2DYQELE+PIl4jSGtSCwKK92mYNlzFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=eRaMcxz3zgFPYNGt7SjAbzHOcdHXj9ZgSC7Zn81PL2M=;
        b=XxgvIpt3dc0cOJY0onf3gfxQ60aUb37Q3K2CUzzr5rzRwL7vewRJkTHW3q1vsQ9FJn
         0SQGS4coCf4kemRocqZ+IRCc+KEYPbIfTpPHgGNJf5JkEOT/OkrbJySLIimcKyf6GFkS
         STO4NagBgIsSbxAWWy8+xHwvxdOAA9IGLHRKxAUOTW5aaa0RPaRlcCZJKX0M7Tqjm0F9
         KbbmcY85K3ZIkuivkf7x8tOSKcoDCvhGaDAfpbvmg0+kYLkBa4umvrK0wA9YBTRYkvhg
         r3FaDdoeVuIERl/ANOvrYcwwFBhc2INKMcX5ROJwp5SUkzi6Ihlm8Zi6rZK7Wda4RRbQ
         LwNQ==
X-Gm-Message-State: AOAM533T0MaJytoJo1Ho5+Xk8BKZGmWAixP3aVVaLi7Vy4PSpCr+qfAu
        fKLab2dqCBHg+nk2veDJS6Kubw==
X-Google-Smtp-Source: ABdhPJwAY40s7fwbqph5oDTyB7TSOu75px+R8zevxVJSWWfJPeejFa8vysnU4+SyKebV8pJS/9JSqA==
X-Received: by 2002:a1c:254:: with SMTP id 81mr946479wmc.77.1617878334782;
        Thu, 08 Apr 2021 03:38:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm38073759wrh.88.2021.04.08.03.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 03:38:54 -0700 (PDT)
Date:   Thu, 8 Apr 2021 12:38:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Imre Deak <imre.deak@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-intel-fixes tree
Message-ID: <YG7dPD8NWbHLrFck@phenom.ffwll.local>
Mail-Followup-To: Imre Deak <imre.deak@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210326195838.5ad4973b@canb.auug.org.au>
 <20210329090117.6b224931@canb.auug.org.au>
 <20210329182335.GE233691@ideak-desk.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329182335.GE233691@ideak-desk.fi.intel.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 09:23:35PM +0300, Imre Deak wrote:
> Hi Stephen,
> 
> thanks for the report.
> 
> On Mon, Mar 29, 2021 at 09:01:17AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > On Fri, 26 Mar 2021 19:58:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > After merging the drm-intel-fixes tree, today's linux-next build
> > > (htmldocs) produced this warning:
> > > 
> > > Documentation/gpu/i915:22: /drivers/gpu/drm/i915/intel_runtime_pm.c:423: WARNING: Inline strong start-string without end-string.
> 
> The problem seems to be the
> 
> 	@ignore_usecount=true
> 
> part in __intel_runtime_pm_get_if_active()'s docbook documentation. I
> can't see the problem with it, it was meant as a reference to the
> function parameter, granted I'm not sure what's the proper markup syntax
> for this.
> 
> I will follow up with the following change which suppresses the warning
> and renders the html as expected unless someone can suggest a better
> way:
> 
> - * If @ignore_usecount=true, a reference will be acquired even if there is no
> + * If @ignore_usecount is true, a reference will be acquired even if there is no

Yeah you can't just use most pseudo-code in kerneldoc because it's
interpreted as raw .rst. So would need some .rst quoting of some sorts to
make it render correctly.

Usually for pseudo-code I go with blockquotes (started with :: at the end
of the previous line, plus indenting), that gives you also a nice
fixed-width font and everything.

Aside from the hyperlink stuff plain English works best in the text parts.
-Daniel

> 
> --Imre
> 
> > > 
> > > Introduced by commit
> > > 
> > >   8840e3bd981f ("drm/i915: Fix the GT fence revocation runtime PM logic")
> > 
> > This warning now exists in Linus' tree.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
