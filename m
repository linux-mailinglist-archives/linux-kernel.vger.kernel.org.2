Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894AB426029
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhJGXG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhJGXG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:06:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD2DC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:05:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i12so11167483wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYQMWLLbu4oAeC9vWdtr95CG6fnYY9mz2J/L0vi71cM=;
        b=AUwYbpgNqT4cwYjyKzu/7Ew6CwM9L/Pmrv57z24yxHmZ6yu/abf7ATX0pRIDQcDeRV
         VHPQaQ9l+73am/TpokQUOyZNW4swT0ovKgbxUuomZ8w3vlcitN2X180iWy7me5qGT5WX
         fCnEi5RjOpy6gDIs6wvzkh6XuWZFy/7ffWtV2MPC3ooAUMyEKmoQPkGgjquBNVvuMdxp
         wYEj3ktCmDRZF8M2vtYJT2YbVPWtg+Ua5ukxJtxl7aQmm+0wISPHR6qv5jVyaN66Ceqn
         V4q4ZHwdneVkgzNomhDvXwy7vdaqnM+wsVFFc/CfUWLsnA/24gx6JOWo84HNCORwhTuI
         l23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYQMWLLbu4oAeC9vWdtr95CG6fnYY9mz2J/L0vi71cM=;
        b=FO0z0KoKzZFkfmYVHgTWOvRSCZAiPyWtuEhhu8NofGD80gj1vHVrnEP7Qp5sLTZwUD
         XFuWa27icnVwQYfh3V8q3km5ARhtTkOwCVt30BFU9RO8CtdlU4RDsla5LRRAwujps+/i
         8y0QD0CDLO+lTRg95W5uadXbovuX5Qe7l04OIHT1+iEzWdMGq42IEs1iO/6CGxFytRSr
         DCv40YCGcUn/g+WUYEtE7T8rQ3K7TkrHAEJ4hszQqBBKnzx7dqI/1ffXAleWRZZBZ2Bq
         W/43u9c3mE4Vy676CBJeL92jabJp49hgZE1nqxPi9osXyxqOMK4/TK6vvm/vHFvA//vd
         UB8w==
X-Gm-Message-State: AOAM5335OG6QZg1LFgBM4EalbJIE0lUl38ChtWJsDinmf0dmxpNgWIF+
        FxMGXjW8w7mYm7wBPqQLVreBsQ==
X-Google-Smtp-Source: ABdhPJzXWDSN4tZQ5R4ID5njTcxHUIsRt5nqG+rUxTVCuAV+xTWjfh9+vrQa1i3ZAW3jxKeT5mxnyQ==
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr7448068wmk.143.1633647900215;
        Thu, 07 Oct 2021 16:05:00 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id h17sm636754wrx.55.2021.10.07.16.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 16:04:59 -0700 (PDT)
Date:   Fri, 8 Oct 2021 00:04:57 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Prediger <lumip@lumip.de>
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YV99GcLzSuWFQFl0@equinox>
References: <YT5BO7bUMMkwNCTh@equinox>
 <20210912191207.74449-1-lumip@lumip.de>
 <42492b83-8741-786d-1b6e-cdd122576ae3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42492b83-8741-786d-1b6e-cdd122576ae3@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 01:52:44PM -0700, Randy Dunlap wrote:
> On 9/12/21 12:12 PM, Lukas Prediger wrote:
> > diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> > index 3b4c0506de46..bac5bbf93ca0 100644
> > --- a/Documentation/userspace-api/ioctl/cdrom.rst
> > +++ b/Documentation/userspace-api/ioctl/cdrom.rst
> > @@ -54,6 +54,9 @@ are as follows:
> >   	CDROM_SELECT_SPEED	Set the CD-ROM speed
> >   	CDROM_SELECT_DISC	Select disc (for juke-boxes)
> >   	CDROM_MEDIA_CHANGED	Check is media changed
> > +	CDROM_TIMED_MEDIA_CHANGE	Check if media changed
> > +					since given time
> > +					(struct cdrom_timed_media_change_info)
> >   	CDROM_DRIVE_STATUS	Get tray position, etc.
> >   	CDROM_DISC_STATUS	Get disc type, etc.
> >   	CDROM_CHANGER_NSLOTS	Get number of slots
> 
> Hi Lukas, Phil,
> 
> This doc change causes a documentation build warning:
> 
> Documentation/userspace-api/ioctl/cdrom.rst:57: WARNING: Malformed table.
> Text in column margin in table line 42.
> 
> The "=====" lines describe the table columns and they cannot be
> exceeded without a warning. The table needs to be reformatted.
> 
> Lukas, will you handle that?
> thanks.
> 
> 
> ======================  ===============================================
> CDROMPAUSE              Pause Audio Operation
> CDROMRESUME             Resume paused Audio Operation
> CDROMPLAYMSF            Play Audio MSF (struct cdrom_msf)
> CDROMPLAYTRKIND         Play Audio Track/index (struct cdrom_ti)
> CDROMREADTOCHDR         Read TOC header (struct cdrom_tochdr)
> CDROMREADTOCENTRY       Read TOC entry (struct cdrom_tocentry)
> CDROMSTOP               Stop the cdrom drive
> CDROMSTART              Start the cdrom drive
> CDROMEJECT              Ejects the cdrom media
> CDROMVOLCTRL            Control output volume (struct cdrom_volctrl)
> CDROMSUBCHNL            Read subchannel data (struct cdrom_subchnl)
> CDROMREADMODE2          Read CDROM mode 2 data (2336 Bytes)
>                         (struct cdrom_read)
> CDROMREADMODE1          Read CDROM mode 1 data (2048 Bytes)
>                         (struct cdrom_read)
> CDROMREADAUDIO          (struct cdrom_read_audio)
> CDROMEJECT_SW           enable(1)/disable(0) auto-ejecting
> CDROMMULTISESSION       Obtain the start-of-last-session
>                         address of multi session disks
>                         (struct cdrom_multisession)
> CDROM_GET_MCN           Obtain the "Universal Product Code"
>                         if available (struct cdrom_mcn)
> CDROM_GET_UPC           Deprecated, use CDROM_GET_MCN instead.
> CDROMRESET              hard-reset the drive
> CDROMVOLREAD            Get the drive's volume setting
>                         (struct cdrom_volctrl)
> CDROMREADRAW            read data in raw mode (2352 Bytes)
>                         (struct cdrom_read)
> CDROMREADCOOKED         read data in cooked mode
> CDROMSEEK               seek msf address
> CDROMPLAYBLK            scsi-cd only, (struct cdrom_blk)
> CDROMREADALL            read all 2646 bytes
> CDROMGETSPINDOWN        return 4-bit spindown value
> CDROMSETSPINDOWN        set 4-bit spindown value
> CDROMCLOSETRAY          pendant of CDROMEJECT
> CDROM_SET_OPTIONS       Set behavior options
> CDROM_CLEAR_OPTIONS     Clear behavior options
> CDROM_SELECT_SPEED      Set the CD-ROM speed
> CDROM_SELECT_DISC       Select disc (for juke-boxes)
> CDROM_MEDIA_CHANGED     Check is media changed
> CDROM_TIMED_MEDIA_CHANGE        Check if media changed
>                                 since given time
>                                 (struct cdrom_timed_media_change_info)
> CDROM_DRIVE_STATUS      Get tray position, etc.
> CDROM_DISC_STATUS       Get disc type, etc.
> CDROM_CHANGER_NSLOTS    Get number of slots
> CDROM_LOCKDOOR          lock or unlock door
> CDROM_DEBUG             Turn debug messages on/off
> CDROM_GET_CAPABILITY    get capabilities
> CDROMAUDIOBUFSIZ        set the audio buffer size
> DVD_READ_STRUCT         Read structure
> DVD_WRITE_STRUCT        Write structure
> DVD_AUTH                Authentication
> CDROM_SEND_PACKET       send a packet to the drive
> CDROM_NEXT_WRITABLE     get next writable block
> CDROM_LAST_WRITTEN      get last block written on disc
> ======================  ===============================================
> 
> 
> -- 
> ~Randy

Hi Randy,

Thanks for heads up. I've prepared a patch to reformat the table which
I'll send shortly.

Regards,
Phil
