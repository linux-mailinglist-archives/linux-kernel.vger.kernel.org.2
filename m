Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBEE404231
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348333AbhIIASx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbhIIASv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:18:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C77C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 17:17:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i28so5817459wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4mArSH7G9IZ7XqgpkIZ7ImKPZkCvYG4aBld2zu+Umc=;
        b=c2rSfW+bQ6c7D4copk2J655EJKmMQzScj2gh0/eC2YLJsqVx9R819sBU+kLqSVVenY
         x3zfb5IjyhYjY/XrRnR2Rjvcyslk107X/aU0XAMQrs5uqFdVjDBfa9FOB1vMsXLJUVuL
         fwrxg7lHc4uJeMKseAraotnDd1YOc7tm0tWaCdlfdzprbDhpmtk+obiSx4H5qen84wdI
         QguXlzU7mVVIGOUuVDMdnNXgr9B0/PFkrZqfvusqDTnypHMnRJZo7nrsvVQKsvo+fvI9
         d0ObWVw9VH6WWVVQiaiSu3wWk8dB9tm7Vh6Nl6NWjBDcGOd+aWqFsMDpRuQPLwEgRL29
         3QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4mArSH7G9IZ7XqgpkIZ7ImKPZkCvYG4aBld2zu+Umc=;
        b=vx4qeutTH+Woz5zN6QsauxY05kwOJCPoiCEi7CvIh52hbg3pRZYcaLhOSzVMK3HY8h
         IIsezrJGM71jo6KGAPirFAj+4w7++Rn1FdOU8DDTPhVXBGGTbqmGH+xxTd96lv37FqyN
         0UpIWX5jaNf1BAhKbrTuOXza6iolTKXJYnh6RcQW4nmTWSW21Mh+Ym+vddx1cA+GEXAj
         G4cjSTZeUL9JkOl9K3b+D1fvpiBMf0Byn+wIIChi8JAocmBOhVymJFCngT0sX7H8+mP7
         RjGNriJzwGEYZsSqb578OA4RohycZCvKicj4O9XScjkDLXk7yuKS87zAvREdgL5wV9FI
         ZidQ==
X-Gm-Message-State: AOAM532scp3cuPKGusQsa1+07eS89E21NeKsdn+j+doa3u19h6Y6BPcG
        pweo4iVqY4X7qvR0F2TtdKQEbw==
X-Google-Smtp-Source: ABdhPJwycgDWh43YpmlmxV9M857bpmXuUgIrt9UEjiE/hyy0/1sJOU/9hfuDOO+nSx+DhEaFENEjNQ==
X-Received: by 2002:a5d:48d2:: with SMTP id p18mr287844wrs.334.1631146661266;
        Wed, 08 Sep 2021 17:17:41 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id l124sm80824wml.8.2021.09.08.17.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 17:17:40 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     hch@infradead.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, lumip@lumip.de,
        Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change detection
Date:   Thu,  9 Sep 2021 01:17:21 +0100
Message-Id: <20210909001721.2030-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YTcILRYw/AKen0X4@infradead.org>
References: <YTcILRYw/AKen0X4@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
> > +		unsigned long arg)
> > +{
> > +	int ret;
> > +	struct cdrom_timed_media_change_info __user *info;
> > +	struct cdrom_timed_media_change_info tmp_info;
> > +
> > +	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
> > +		return -ENOSYS;
> > +
> > +	info = (struct cdrom_timed_media_change_info __user *)arg;
> > +	cd_dbg(CD_DO_IOCTL, "entering CDROM_TIMED_MEDIA_CHANGE\n");
> > +
> > +	ret = cdrom_ioctl_media_changed(cdi, CDSL_CURRENT);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (copy_from_user(&tmp_info, info, sizeof(tmp_info)) != 0)
> > +		return -EFAULT;
> > +
> > +	tmp_info.has_changed = ((tmp_info.last_media_change - cdi->last_media_change_ms) < 0);
>
Dear Christoph,

Sorry didn't see this e-mail before I replied to Lukas, so I hope you
don't think I was ignoring you :-)

> Overly long line here, but more importantly this is much cleaner with
> a good old if:
>
>
>	if (tmp_info.last_media_change - cdi->last_media_change_ms) < 0)
>		tmp_info.has_changed = 1;
>

Whilst I don't disagree this is technically cleaner, the existing style
certainly read well to me. In terms of line length, checkpatch doesn't
complain about it, so I guess you mean purely from a visual perspective?

> > +{
> > +	__s64	last_media_change;	/* Timestamp of the last detected media
> > +					 * change in ms. May be set by caller, updated
> > +					 * upon successful return of ioctl.
> > +					 */
> > +	__u64	has_changed;		/* Set to 1 by ioctl if last detected media
>
> More overly long lines.  Also why is has_changed a u64 if it is used as
> a boolean flag?

As this is not a packed struct, would not a smaller value still take up
the same space?

As I'm keen to grow as a maintainer and take feedback, I can certainly
wait for Lukas to reply to this for sure.

Regards,
Phil
