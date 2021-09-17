Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A25410124
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244395AbhIQWKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbhIQWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:10:52 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFDDC061574;
        Fri, 17 Sep 2021 15:09:30 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bi4so15908051oib.9;
        Fri, 17 Sep 2021 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Cx0qBSaOKIf1+QlRCt1cPztoQCTEygYonUUg7sAxaY=;
        b=l1HdWhiffeQWqNzSml/cVySYU+pImMNkrCD2ydYIQGOJsNcGGn+q3f9FllN+X74WrR
         paBnNd+pdrekqjvzTYWfR0ghsbFlYSm6QLJ/RvbFLU0VHzK5/z+tIrXWPzFBadUYtSCE
         MFNdxHBF4jePit079FH5lB9nKltggvOKkbLs8x+9x/WbFxRkl8F/UPrtO5UCGrhHlCyt
         8vOKKXPoczEQAm11xRFDsxYnO/1CR6W5KzmRNnlzRns/y00nF2z0CWJKwAZ81JkQz6o1
         RlSE8q3yPu/IBFY1k/b2CwTEZ6yZEQYIq5xulY2TI01vt38M0LBrHKvVvwlFYuRmg2+t
         V2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8Cx0qBSaOKIf1+QlRCt1cPztoQCTEygYonUUg7sAxaY=;
        b=k0KFN8P37Zo39DElR0pjoc9nK4EBREfPG6IV9cXW5VVu+OZHUiWgAAWNXt4tHHlQkm
         2Ree3t9OhPho5auDQedLUQcAJb7JgRhcUdd/D4WDJ8n1QTvf15mqyPrjNek+rlPzbsVE
         KlG/FqxxAHz+/FqTY/PZhtiQSC4SYIqsofsIBld1+XXZiaOB4OYSF6XsmhU9/57RVvxy
         1ceUK77JfQLYWWAxFn6gV09v65bHsF/FDzi4b2lRSVT+8fuNpmyrvLQnVXzb1idlh3vg
         RiWiU0AiLFeR+xPfePN8sHu3vug4Y/TQIaBxsSeNmt0m62UKAkNp09bonTHlivNyKxJm
         asWw==
X-Gm-Message-State: AOAM5323fPr/jtHzVSj3CrrNvzhNTtmqcp0E673Rhej9W+3aA19ue8tP
        jyiice06JEam3MuXAFyQdgGiSvkDu38=
X-Google-Smtp-Source: ABdhPJzFQ/0sKjRh/cyE3mcdklyy/m8maFBKrQuPrqi2KwRgWl5vcx/69r4p+/K0XzZDJub9ikLgRw==
X-Received: by 2002:a05:6808:642:: with SMTP id z2mr5732135oih.26.1631916569566;
        Fri, 17 Sep 2021 15:09:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y24sm1940032oto.40.2021.09.17.15.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 15:09:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 17 Sep 2021 15:09:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/3] hwmon: Support access to the NCT677x via Asus WMI.
Message-ID: <20210917220927.GA455190@roeck-us.net>
References: <20210917220240.56553-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917220240.56553-1-pauk.denis@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 01:02:37AM +0300, Denis Pauk wrote:
> Support accessing the NCT677x via Asus WMI functions.
> 
> On mainboards that support this way of accessing the chip,
> the driver will usually not work without this option since
> in these mainboards, ACPI will mark the I/O port as used.
> 
> Could you please review?
> 
> @Guenter Roeck, I have removed unrequired error messages.
> 

Series applied.

Thanks,
Guenter
