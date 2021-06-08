Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B852139F503
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhFHLep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:34:45 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:41673 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFHLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:34:42 -0400
Received: by mail-ej1-f42.google.com with SMTP id ho18so21073862ejc.8;
        Tue, 08 Jun 2021 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G+BP9KpLMiX2uAVjVxpsGnt6/gU1fDgwmGkaceT//H4=;
        b=NqWfovay9jF6/bVXGob1BxAHGJdGk8Cgad9J2AsNnLCupji0PXqOnUnrxboFv4WM72
         VB+WVEpCVn3bHhF91xwLP8JcQHKbkcj9tJfv9hrp2dRt6HHUrfckdEm4q2myNkPWLGzi
         aHsB1qecm0/Ot+HQdXGMJddL7gOSs6WDs9zLAsjbEJ37K1gfhd24I1BE+3Nq01MbQdMB
         AY3oQM5GX9+Sg+eatjmg/nxTEGelid/ODzLjQZxgeGtqkR3Pl9t7PtfBNyq5Wwv2AOth
         BXrJc0m68nxbwDFaW6r6OOjUVt8fIwUaJnHkkf6JfR+DJJcJz5l8caL9V9cr3xYZU8k4
         g/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G+BP9KpLMiX2uAVjVxpsGnt6/gU1fDgwmGkaceT//H4=;
        b=m1rmp2HPxX0lkED4WDmgm88wZxNtH8qhKOLyCaoCMr3AVTRi/9JlKBIvONxpmzVN+1
         LYys/7BlExuaSXD5600Eth6LcpAyj+XENkcyRKa1oUoP93IP6OJc/zzhtwnKVbC/7R3G
         6WSVbf0kR5pQFeIuJWXqtZcyQRQhTfOs5AuwmHwelmDj2WlZSJKGkHPHv/hsyn5srtDD
         KNiMvbXF9fImfA7r3csxyQMfpj2tG20TPnlsrFP+93J87EhztcHOUO5wq2Pao5GsE+16
         VTLwFwb4Gxrh1xAcQCpZSoe9pfWQ5zLm1tYA9Ym6v6L7iCWay+31j9M2ese0GDz76tgV
         oMQQ==
X-Gm-Message-State: AOAM530wUPAotqWrv/MFtqAxWQIs6luTk5XOHPK/++RowlM42fxc2ogC
        o3maWefbrv8fd/hOVSbCmgQ=
X-Google-Smtp-Source: ABdhPJwLma3W91zHiisiEUcKmovSWkeb7G6QkV44eGc3PUTbVk9QW8LTWnDHy4bDhBjx/PVDRTKt0w==
X-Received: by 2002:a17:906:c2d6:: with SMTP id ch22mr7897653ejb.227.1623151896876;
        Tue, 08 Jun 2021 04:31:36 -0700 (PDT)
Received: from skbuf ([188.26.52.84])
        by smtp.gmail.com with ESMTPSA id r17sm8704615edt.33.2021.06.08.04.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:31:36 -0700 (PDT)
Date:   Tue, 8 Jun 2021 14:31:35 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] arm64: dts: fix node name for the sysclk
Message-ID: <20210608113135.yjskatkreytptqbm@skbuf>
References: <20210608112658.4087235-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608112658.4087235-1-olteanv@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to add "ls1028a: " to the commit prefix. Shawn, if there are no
objections to the patch, would you mind adding it when applying? Thanks!
