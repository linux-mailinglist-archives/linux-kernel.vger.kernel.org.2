Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14CB34D9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhC2WMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhC2WLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:11:48 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2845AC061762;
        Mon, 29 Mar 2021 15:11:48 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id j10-20020a4ad18a0000b02901b677a0ba98so3323718oor.1;
        Mon, 29 Mar 2021 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GOOHC5swwjR1pbdOp8gONNThtE/MzX6K9f+3UiXPGLQ=;
        b=YzVWW339v08+8TdMNwZ1OjVv35CoTdDmrSzl62PcAxunUg+iL5YpkvV0f6qTfAiiVZ
         nXV5YGXefOsai8HhXozoIvnLgm14ahuFpDT6hBEJFwv8pP7Dfjz+DSN6b8LAf9XRD1oU
         yfRjFQ6BZ9NNRJQYOimUa2OHoGAMF7GWRjJash3HZvVzIHpTKDOLPBZ8zVI+Pl8jIMag
         AndGWx4+Qf5xHIIf+QlIryQ/keVe1cY4/8A2X9nH2WtCwPMu9lX2v3xPVZ1viw2PkvdI
         ey8lAp/w4szq3a4ZM7VN6qUDGju+AJcPNXA29TBjhkTYgSTa0tsebw5Nl6S41Ad+2NsY
         6C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GOOHC5swwjR1pbdOp8gONNThtE/MzX6K9f+3UiXPGLQ=;
        b=bomlXbaDOfHyZt6/yIb3caTCayyJerAwfpWjvOnn+gRaUVSOM9UavLF1BPn5qWS4bL
         FA7+hnG4+juT0PP/tuFnRl2NjiDDwnKdzHvVlSzYtSr6AbHN7duasUiLJY0iMaZmlxt0
         XFymnVbNJeRtJD+hqUEo0swAkxrYaE4vdm9sR3HCnxLlyE/Dbkeboq13UClS6N1xrW6z
         Hi9ms/PJLy3NRItANZe85yWn8/tNISouRDynppLv9jcbcz366l9+1l5070Fo5ASzEFJS
         rfkx+XlN8hxWHVn5+2PNCYm3H8lzVhv1o+MAOEQXtPTVbbLedl7Gt/XnexWx3aAcImBu
         u4Rw==
X-Gm-Message-State: AOAM530Ii/BYATe2rsoRSCK1bOqdo0uApBzQ/V+UC9h1PDpnzN7culKU
        svCzDPTEbhpd0H/XaAKTbHeJJljjsbI=
X-Google-Smtp-Source: ABdhPJyBMq3fE/2knk+IsBueaiYOtZqtudyf1uaCdUofWRMBvDP95ESqjPFwnKITVq8Cbo/0I+tYHw==
X-Received: by 2002:a4a:e4c4:: with SMTP id w4mr23235317oov.68.1617055907600;
        Mon, 29 Mar 2021 15:11:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15sm4830723ote.27.2021.03.29.15.11.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Mar 2021 15:11:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Mar 2021 15:11:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/tps53679) Add support for TI
 TPS53676
Message-ID: <20210329221145.GA223180@roeck-us.net>
References: <20210322193734.75127-1-erik.rosen@metormote.com>
 <20210322193734.75127-3-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322193734.75127-3-erik.rosen@metormote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:37:34PM +0100, Erik Rosen wrote:
> Add support for TI TPS53676 controller to the tps53679 pmbus driver
> 
> The driver uses the USER_DATA_03 register to figure out how many phases
> are enabled and to which channel they are assigned, and sets the number
> of pages and phases accordingly.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

Applied to hwmon-next.

Thanks,
Guenter
