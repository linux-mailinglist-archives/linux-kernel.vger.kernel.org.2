Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E11351D83
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhDAS27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:28:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58858 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237870AbhDASEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:04:47 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lRwdP-00EKSD-DR; Thu, 01 Apr 2021 14:41:15 +0200
Date:   Thu, 1 Apr 2021 14:41:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Benedikt Spranger <b.spranger@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/32] Documentation: net: dsa: update configuration.rst
 reference
Message-ID: <YGW/a8FuCO+Q6hEg@lunn.ch>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
 <a3d52c1380624f34b4a04e9698f67e1e6d8d23f8.1617279356.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d52c1380624f34b4a04e9698f67e1e6d8d23f8.1617279356.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:17:50PM +0200, Mauro Carvalho Chehab wrote:
> The file name: Documentation/configuration.txt
> should be, instead: Documentation/networking/dsa/configuration.rst.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 75b8988dfe83 ("cifsd: add server handler for central processing and tranport layers")
> Fixes: 58dd7a8d9d02 ("Documentation: net: dsa: Describe DSA switch configuration")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/filesystems/cifs/cifsd.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/cifs/cifsd.rst b/Documentation/filesystems/cifs/cifsd.rst
> index 48ae58f2a53c..082a839535e7 100644
> --- a/Documentation/filesystems/cifs/cifsd.rst
> +++ b/Documentation/filesystems/cifs/cifsd.rst
> @@ -114,7 +114,7 @@ How to run
>  	# ksmbd.adduser -a <Enter USERNAME for SMB share access>
>  
>  3. Create /etc/ksmbd/smb.conf file, add SMB share in smb.conf file
> -	- Refer smb.conf.example and Documentation/configuration.txt
> +	- Refer smb.conf.example and Documentation/networking/dsa/configuration.rst
>  	  in ksmbd-tools

Hi Mauro

This looks wrong. There is no relationship between SMB and DSA. I
suspect you are looking for some other configuration.txt

	Andrew
