Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2D32560A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBYTE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:04:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233571AbhBYTE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614279779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFKozbHhnqP0a9+4FvYtN86/9o6SBDgQyBJdWAPtLYc=;
        b=exv++/JG8B7WNECsKCbl8T2pYB4UyQZ76/Fufy+ROwP0UrKSFRVSJbVw92yKCYacGJZ2N/
        ee6Vs1Sr3+08PLxTt+c57N/CPBXZ3fwspQJ6sZJ5HxpkaJX2gjc4JOB50WjRPYCavI8kGR
        d4OWjLl5fH0h1xcI65si014Vu/HuYmE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-zW3UX46jNZWrN4pVJdZ5Ew-1; Thu, 25 Feb 2021 14:02:57 -0500
X-MC-Unique: zW3UX46jNZWrN4pVJdZ5Ew-1
Received: by mail-wm1-f72.google.com with SMTP id w20so2359337wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XFKozbHhnqP0a9+4FvYtN86/9o6SBDgQyBJdWAPtLYc=;
        b=Sy/dIFvKuEv8yEiCpCxOntpjb2E7477w2HzUlQt0sWz6+udQpy54f2zReFGmSus1Np
         16X3y5VOB91DttZ7yhgCdXUS1Jgu/FA54N33WGmJ1RFAlT1pR+ELDqEQNlThviYqKNOp
         Kb8cgA1ZxJMAgI1Fhw/g0J+xdy2DA49SmyFGjHcG4csb5JvO2YSBDIYydLBKSGeWVdac
         RgjiF4z12671KC1mF7tWrV31zimYrMNtG8XtTMln8Zu12irK+/oxuhtfef2nL9pZhLkx
         EhOJKfgXAztqd4Si/ooB5fzqyal+27jIk6rzAt3IkKAPyirgtkc2gcEjMXn8d0Q5xN+Y
         abtA==
X-Gm-Message-State: AOAM530c4iEdOqM6iASa6SuLttw8I39WyVkLwc+fCyyWVnbtMcoyajSz
        cwAxnqxKlJF4L6d7JyNVGZNtlu4uMHReGrA/jdDtd3/SLW766ZSnMPRcI3ycYQJ/JRJcDyk8KKf
        hS2+JTN9PIVqJfpEHciOcfAr5
X-Received: by 2002:adf:f750:: with SMTP id z16mr5053155wrp.108.1614279774388;
        Thu, 25 Feb 2021 11:02:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyofpaHNGnRewH6YHzPuJRqwWTHK/BQLCP4h/Yb+AZpMyiGXAnajZWb3bS8LQE8CSJUwyqDIA==
X-Received: by 2002:adf:f750:: with SMTP id z16mr5053138wrp.108.1614279774228;
        Thu, 25 Feb 2021 11:02:54 -0800 (PST)
Received: from redhat.com (212.116.168.114.static.012.net.il. [212.116.168.114])
        by smtp.gmail.com with ESMTPSA id s11sm8971320wme.22.2021.02.25.11.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:02:53 -0800 (PST)
Date:   Thu, 25 Feb 2021 14:02:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] ALSA: virtio: PCM substream operators
Message-ID: <20210225135951-mutt-send-email-mst@kernel.org>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-7-anton.yakovlev@opensynergy.com>
 <s5h35xkquvj.wl-tiwai@suse.de>
 <d9b6e8fa-7356-1cbf-029b-6f7c8bad4994@opensynergy.com>
 <s5hlfbcpayj.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlfbcpayj.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 01:51:16PM +0100, Takashi Iwai wrote:
> On Thu, 25 Feb 2021 13:14:37 +0100,
> Anton Yakovlev wrote:
> > 
> > On 25.02.2021 11:55, Takashi Iwai wrote:
> > > On Mon, 22 Feb 2021 16:34:41 +0100,
> > > Anton Yakovlev wrote:
> > >> +static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
> > >> +{
> > >> +     struct virtio_pcm *vpcm = snd_pcm_substream_chip(substream);
> > >> +     struct virtio_pcm_substream *vss = NULL;
> > >> +
> > >> +     if (vpcm) {
> > >> +             switch (substream->stream) {
> > >> +             case SNDRV_PCM_STREAM_PLAYBACK:
> > >> +             case SNDRV_PCM_STREAM_CAPTURE: {
> > >
> > > The switch() here looks superfluous.  The substream->stream must be a
> > > good value in the callback.  If any, you can put WARN_ON() there, but
> > > I don't think it worth.
> > 
> > At least it doesn't do any harm.
> 
> It does -- it makes the readability worse, and that's a very important
> point.
> 
> > >> +static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
> > >> +                              struct snd_pcm_hw_params *hw_params)
> > >> +{
> > > ....
> > >> +     return virtsnd_pcm_msg_alloc(vss, periods, period_bytes);
> > >
> > > We have the allocation, but...
> > >
> > >> +static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
> > >> +{
> > >> +     return 0;
> > >
> > > ... no release at hw_free()?
> > > I know that the free is present in the allocator, but it's only for
> > > re-allocation case, I suppose.
> > 
> > When the substream stops, sync_ptr waits until the device has completed
> > all pending messages. This wait can be interrupted either by a signal or
> > due to a timeout. In this case, the device can still access messages
> > even after calling hw_free(). It can also issue an interrupt, and the
> > interrupt handler will also try to access message structures. Therefore,
> > freeing of already allocated messages occurs either in hw_params() or in
> > dev->release(), since there it is 100% safe.
> 
> OK, then it's worth to document it about this object lifecycle.
> The buffer management of this driver is fairly unique, so otherwise it
> confuses readers.
> 
> 
> thanks,
> 
> Takashi

Takashi given I was in my tree for a while and I planned to merge
it this merge window. I can still drop it but there are
unrelated patches behind these in the tree so that's a rebase
which will invalidate my testing, I'm just concerned about
meeting the merge window.

Would it be ok to merge this as is and then address
readability stuff by patches on top?
If yes please send acks!
If you want to merge it yourself instead, also please say so.

-- 
MST

