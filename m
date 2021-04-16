Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65810361EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbhDPL26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:28:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:38723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237255AbhDPL24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618572502;
        bh=wAk6nryVaB1E5Jn0yyF6letaOhPQ1lcC+dwMpNF02C4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=A6TUpE+FpBBvlNJxZ3ozCDgX0xyr2uxCa+jM3OvW8xIbNG620WT9yiv1mvoRCotFR
         PoEVJr5cOqBNPRyAh5iCbXedPMJgFrTljc/Zs1fG1aDAlrmyCwt/GraHr9brJ/zD/a
         JVHGcfQgDJgvMQ3yTvY7XzrVZv12wP1ayjS0NkPs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.210]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5Q5-1lLUHZ1OK7-00FDUa; Fri, 16
 Apr 2021 13:28:22 +0200
Message-ID: <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
Subject: Re: x86/crash: fix crash_setup_memmap_entries() out-of-bounds access
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org
Date:   Fri, 16 Apr 2021 13:28:19 +0200
In-Reply-To: <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
         <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xkplCq2by6TqdPkZ5R3M78L+p9XnrTay7+ck73oGKKp3djkMMTk
 T3m96P0z0W2gAY0nPbDdCztrvwJ1vMzNI/fqZgtTImODW4W2L0gAbmWgluNjP70d03h0VIF
 Q7GL+KMm47YGhsdrGLjrBBTXe9p/y9w8hz318wp4iiBW9R7sqxazRXefHoeRQE0/uSOZOxn
 1uhpdeoogFUpX4D7yN3HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zxVcoockpp0=:kaJJ19vlOjz+HiA+kgb3rD
 JgB+rnbsD0ayMeoGHH4srGuTxrpKjr61+P38CjrTRLlk7TaeF93ePsB8B2Xzda2QgtceXnw0X
 ERdTXtNy7Nf2/AdpY6qsR3FwiVq1OBRy3ZMPmQsUQ4RFyIOTRButDu873vzaIh66bTjXd8tkv
 lqvQxi8abWvNaY4fsOrF3R6ERLfU7nG2fvzebrplaq3W14C5ZBdz9M0AxH+G/AvqK1ngX1pQT
 B3RxA1+0bW+DXKE3ILLbKptOfS+j4D3CPVmskopzNjuR9F0INc8XNvWSzOSWNoLMTeSihHt3p
 T8qIQ8unOEIanOrbhauk7mvyhiQzIlZdWiOx1h8cZTuhTPnV9gu2pt4L6WWJMcg+D15XGm5pn
 /hHalVYbjOxM2nG5ISnr4XB7qi4LknawzNp7pe+42ISyBxCYMokDXKnLSVFgeiMduio9exCWf
 I+/VIWuXwA6jcxJgH7J4Ks+kuGr1a+fBG0FAAQuOOVtQGM0iuvUCYmituciMjByFHOstKMQT2
 DPiNkV/4HBO9dabQPWZpKM/ULeGWkxmNV0DfCkndmGvdkp7puYYuuGNqKXkyD/X5GGRlGfYs4
 RyI8UcthBE68J++9toYLY/w0i7CoZCXwn9TQBYKuAX0+VAMsy9UJMMvyPlhlnuYwSUFX+Pzkk
 MEXl+dUNZy5HTMKqfuFQBy1ED3eFbGAgMlXTIDt8e6DFcLZ+BZi2cCQKnbNyp72q+pYoH6v0w
 /NpC1s8JDP/0r+pCr81h5Mg5y8ga6cm9nNuZSV4Or/9eXIQDtJ/KBj2jBiG8UpQj5+XBv+5Nv
 blVmVcFZYZP3p2CJONd1JlqMyF+/y0XxZ58zc3SiyHOU9kQ3uTdSnWMSgtPJ94mNnBPqBV13U
 e937LaHCoYYVsE9wHXp83ba0jEelqiaSRYiXUdd3+g2NkKLsFiJ3d5t16arEiOjn1Phbb9sBq
 cY1rexaxR30b8cl89OokcfXBMhdI+mUZQXhP5Zjzs5TXqwgpAYFBqmYho23bgrjCik4ctZt5n
 C1ylj01WLgWaHpdNbDUOvL1mZhlnxMbEgsdsdq+2OckOYRwxO7XEo5WLkyN+H1IUBhvoUW79c
 Uq/N9GoJFJFID93DXRLHLfTqtK55/uBazVilW4Ckert7+v+E9fL1GeZZhuOGcY1TETsHC1UhR
 tELq7aSuDKMPQ3JV+Z6KBkHFAPfyXXmDVUaK/StHHtnbpQ/P1HCIRoDBb7jv5YaHgZ1DU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-16 at 19:07 +0800, Dave Young wrote:
>
> > We're excluding two ranges, allocate the scratch space we need to do t=
hat.
>
> I think 1 range should be fine, have you tested 1?

Have now, and vzalloc(struct_size(cmem, ranges, 1)) worked just fine.

	-Mike

