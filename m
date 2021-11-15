Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF044FEB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 07:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhKOGig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 01:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKOGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 01:38:35 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E79CC061746;
        Sun, 14 Nov 2021 22:35:38 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id k21so19823712ioh.4;
        Sun, 14 Nov 2021 22:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b4fvqDDf6essZfXy79w2PNvmxcSudSs8Qm8jMkhMQ/o=;
        b=SgJc8rP6dclkFpj8SusPUsEDesB7bKWqz+0diakpphYw6jItvtu0VSbcbSPN5XBm7O
         E1VyX8y+mRC56Nj3snr0I9lpSEw2p4DQwIOo4+pnZpwq9FA1u70jTXG1m393X+5BTTzH
         OQLfwrPrRTXjp1e+AB2F2UtC50dGWDsx1RFR0IYMWxdDL05wAHNZkJyBpP9OzodEi6kL
         aGH/j8y+jwmFRwD5lCBsbrWHNoeO56joifxH8QFK8lqEGpig/x+V1znj7wYUzaeeWpX/
         MLtD5WcCshdwViuP3YE2ykUxoKUIQUsvuJbPo30RVqg6nEd51xlKe5gJ7keltpclOlf8
         k3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b4fvqDDf6essZfXy79w2PNvmxcSudSs8Qm8jMkhMQ/o=;
        b=BKRPiQXG2HlY2efK+/coDhdA652v9h2kHzrGvGYwnoiErp3yCAWuwBDoqrslCMl+Es
         AQ4NDE1YTG1NWmJshJz5kvo7F5BzGMc/FptPq7f14NCPJz6gDh/hEWiaMcaR7r2V1gdo
         tKAg9AjJR/i56rgUSPRzNHONHgEUAjCaHe5O7eSiT5JITVwkVxyftWuO+L4b7DbFoPmj
         DxGVZVEQGqoaFKekplHMF5oEXjxYdlLSLrPOqx7tCQB6sl3AE2e/yxRd937gFIpEmNJO
         6TuvBSQJJxREpUtLX2/Q9dUw1dCwcaPl2ScUsIp1Xh+eHqydj1x8b6tyEryolsqmMZXl
         Afow==
X-Gm-Message-State: AOAM531zsVeMCJ+RwCt4Ah/TQHrK2TJN6FxBe42gGJQf4or1XId8eRzt
        2oHE0SrNPIULTv6N3Nx654q3dfSrXZrKrpyw67c5tgu9r8U=
X-Google-Smtp-Source: ABdhPJz9012bHo4ysUcT0wV5YXRIXpOUOPswp6ajBewTK2YiwxZa18coA9VDwi+eJQ2P7NWHbPiTs6voU0+zCYZxxxk=
X-Received: by 2002:a5d:9d92:: with SMTP id ay18mr24491499iob.130.1636958137862;
 Sun, 14 Nov 2021 22:35:37 -0800 (PST)
MIME-Version: 1.0
References: <2c704ddd-2da2-138b-4928-890e92b66f9f@gmail.com>
In-Reply-To: <2c704ddd-2da2-138b-4928-890e92b66f9f@gmail.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Mon, 15 Nov 2021 14:35:02 +0800
Message-ID: <CAJy-Am=uf5Wu1cd=XrYv=+AwJJkqhrcisADRPtvn987Vs8xqAQ@mail.gmail.com>
Subject: Re: [PATCH] docs: Update Sphinx requirements
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 5:16 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> Subject: [PATCH] docs: Update Sphinx requirements
>
> Commit f546ff0c0c07 ("Move our minimum Sphinx version to 1.7") raised
> the minimum version to 1.7.
>
> For pdfdocs, sphinx_pre_install says:
>
>     note: If you want pdf, you need at least Sphinx 2.4.4.
>
> , and current requirements.txt installs Sphinx 2.4.4.
>
> Update Sphinx versions mentioned in docs and remove a note on earlier
> Sphinx versions.
>
> Update zh_CN and it_IT translations as well.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Reviewed-by: Alex Shi <alexs@kernel.org>

> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
> Cc: Alex Shi <alexs@kernel.org>
> ---
>  Documentation/doc-guide/sphinx.rst            | 22 ++++++++----------
>  Documentation/process/changes.rst             |  2 +-
>  .../translations/it_IT/doc-guide/sphinx.rst   | 23 ++++++++-----------
>  .../translations/it_IT/process/changes.rst    |  2 +-
>  .../translations/zh_CN/doc-guide/sphinx.rst   | 21 ++++++++---------
>  5 files changed, 29 insertions(+), 41 deletions(-)
>
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide=
/sphinx.rst
> index ec3e71f56009..e445cb146efe 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -27,7 +27,7 @@ Sphinx Install
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  The ReST markups currently used by the Documentation/ files are meant to=
 be
> -built with ``Sphinx`` version 1.3 or higher.
> +built with ``Sphinx`` version 1.7 or higher.
>
>  There's a script that checks for the Sphinx requirements. Please see
>  :ref:`sphinx-pre-install` for further details.
> @@ -43,10 +43,6 @@ or ``virtualenv``, depending on how your distribution =
packaged Python 3.
>
>  .. note::
>
> -   #) Sphinx versions below 1.5 don't work properly with Python's
> -      docutils version 0.13.1 or higher. So, if you're willing to use
> -      those versions, you should run ``pip install 'docutils=3D=3D0.12'`=
`.
> -
>     #) It is recommended to use the RTD theme for html output. Depending
>        on the Sphinx version, it should be installed separately,
>        with ``pip install sphinx_rtd_theme``.
> @@ -55,13 +51,13 @@ or ``virtualenv``, depending on how your distribution=
 packaged Python 3.
>        those expressions are written using LaTeX notation. It needs texli=
ve
>        installed with amsfonts and amsmath in order to evaluate them.
>
> -In summary, if you want to install Sphinx version 1.7.9, you should do::
> +In summary, if you want to install Sphinx version 2.4.4, you should do::
>
> -       $ virtualenv sphinx_1.7.9
> -       $ . sphinx_1.7.9/bin/activate
> -       (sphinx_1.7.9) $ pip install -r Documentation/sphinx/requirements=
.txt
> +       $ virtualenv sphinx_2.4.4
> +       $ . sphinx_2.4.4/bin/activate
> +       (sphinx_2.4.4) $ pip install -r Documentation/sphinx/requirements=
.txt
>
> -After running ``. sphinx_1.7.9/bin/activate``, the prompt will change,
> +After running ``. sphinx_2.4.4/bin/activate``, the prompt will change,
>  in order to indicate that you're using the new environment. If you
>  open a new shell, you need to rerun this command to enter again at
>  the virtual environment before building the documentation.
> @@ -81,7 +77,7 @@ output.
>  PDF and LaTeX builds
>  --------------------
>
> -Such builds are currently supported only with Sphinx versions 1.4 and hi=
gher.
> +Such builds are currently supported only with Sphinx versions 2.4 and hi=
gher.
>
>  For PDF and LaTeX output, you'll also need ``XeLaTeX`` version 3.1415926=
5.
>
> @@ -104,8 +100,8 @@ command line options for your distro::
>         You should run:
>
>                 sudo dnf install -y texlive-luatex85
> -               /usr/bin/virtualenv sphinx_1.7.9
> -               . sphinx_1.7.9/bin/activate
> +               /usr/bin/virtualenv sphinx_2.4.4
> +               . sphinx_2.4.4/bin/activate
>                 pip install -r Documentation/sphinx/requirements.txt
>
>         Can't build as 1 mandatory dependency is missing at ./scripts/sph=
inx-pre-install line 468.
> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> index e35ab74a0f80..b398b8576417 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -54,7 +54,7 @@ mcelog                 0.6              mcelog --versio=
n
>  iptables               1.4.2            iptables -V
>  openssl & libcrypto    1.0.0            openssl version
>  bc                     1.06.95          bc --version
> -Sphinx\ [#f1]_        1.3              sphinx-build --version
> +Sphinx\ [#f1]_         1.7              sphinx-build --version
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
>  .. [#f1] Sphinx is needed only to build the Kernel documentation
> diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Docu=
mentation/translations/it_IT/doc-guide/sphinx.rst
> index 0046d75d9a70..9762452c584c 100644
> --- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
> +++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
> @@ -35,7 +35,7 @@ Installazione Sphinx
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  I marcatori ReST utilizzati nei file in Documentation/ sono pensati per =
essere
> -processati da ``Sphinx`` nella versione 1.3 o superiore.
> +processati da ``Sphinx`` nella versione 1.7 o superiore.
>
>  Esiste uno script che verifica i requisiti Sphinx. Per ulteriori dettagl=
i
>  consultate :ref:`it_sphinx-pre-install`.
> @@ -53,11 +53,6 @@ pacchettizzato dalla vostra distribuzione.
>
>  .. note::
>
> -   #) Le versioni di Sphinx inferiori alla 1.5 non funzionano bene
> -      con il pacchetto Python docutils versione 0.13.1 o superiore.
> -      Se volete usare queste versioni, allora dovere eseguire
> -      ``pip install 'docutils=3D=3D0.12'``.
> -
>     #) Viene raccomandato l'uso del tema RTD per la documentazione in HTM=
L.
>        A seconda della versione di Sphinx, potrebbe essere necessaria
>        l'installazione tramite il comando ``pip install sphinx_rtd_theme`=
`.
> @@ -67,13 +62,13 @@ pacchettizzato dalla vostra distribuzione.
>        utilizzando LaTeX. Per una corretta interpretazione, =C3=A8 necess=
ario aver
>        installato texlive con i pacchetti amdfonts e amsmath.
>
> -Riassumendo, se volete installare la versione 1.7.9 di Sphinx dovete ese=
guire::
> +Riassumendo, se volete installare la versione 2.4.4 di Sphinx dovete ese=
guire::
>
> -       $ virtualenv sphinx_1.7.9
> -       $ . sphinx_1.7.9/bin/activate
> -       (sphinx_1.7.9) $ pip install -r Documentation/sphinx/requirements=
.txt
> +       $ virtualenv sphinx_2.4.4
> +       $ . sphinx_2.4.4/bin/activate
> +       (sphinx_2.4.4) $ pip install -r Documentation/sphinx/requirements=
.txt
>
> -Dopo aver eseguito ``. sphinx_1.7.9/bin/activate``, il prompt cambier=C3=
=A0 per
> +Dopo aver eseguito ``. sphinx_2.4.4/bin/activate``, il prompt cambier=C3=
=A0 per
>  indicare che state usando il nuovo ambiente. Se aprite un nuova sessione=
,
>  prima di generare la documentazione, dovrete rieseguire questo comando p=
er
>  rientrare nell'ambiente virtuale.
> @@ -94,7 +89,7 @@ Generazione in PDF e LaTeX
>  --------------------------
>
>  Al momento, la generazione di questi documenti =C3=A8 supportata solo da=
lle
> -versioni di Sphinx superiori alla 1.4.
> +versioni di Sphinx superiori alla 2.4.
>
>  Per la generazione di PDF e LaTeX, avrete bisogno anche del pacchetto
>  ``XeLaTeX`` nella versione 3.14159265
> @@ -119,8 +114,8 @@ l'installazione::
>         You should run:
>
>                 sudo dnf install -y texlive-luatex85
> -               /usr/bin/virtualenv sphinx_1.7.9
> -               . sphinx_1.7.9/bin/activate
> +               /usr/bin/virtualenv sphinx_2.4.4
> +               . sphinx_2.4.4/bin/activate
>                 pip install -r Documentation/sphinx/requirements.txt
>
>         Can't build as 1 mandatory dependency is missing at ./scripts/sph=
inx-pre-install line 468.
> diff --git a/Documentation/translations/it_IT/process/changes.rst b/Docum=
entation/translations/it_IT/process/changes.rst
> index 87d081889bfc..dc7193377b7f 100644
> --- a/Documentation/translations/it_IT/process/changes.rst
> +++ b/Documentation/translations/it_IT/process/changes.rst
> @@ -57,7 +57,7 @@ mcelog                 0.6                mcelog --vers=
ion
>  iptables               1.4.2              iptables -V
>  openssl & libcrypto    1.0.0              openssl version
>  bc                     1.06.95            bc --version
> -Sphinx\ [#f1]_         1.3                sphinx-build --version
> +Sphinx\ [#f1]_         1.7                sphinx-build --version
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
>  .. [#f1] Sphinx =C3=A8 necessario solo per produrre la documentazione de=
l Kernel
> diff --git a/Documentation/translations/zh_CN/doc-guide/sphinx.rst b/Docu=
mentation/translations/zh_CN/doc-guide/sphinx.rst
> index 951595c7d599..23eac67fbc30 100644
> --- a/Documentation/translations/zh_CN/doc-guide/sphinx.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/sphinx.rst
> @@ -26,7 +26,7 @@ reStructuredText=E6=96=87=E4=BB=B6=E5=8F=AF=E8=83=BD=E5=
=8C=85=E5=90=AB=E5=8C=85=E5=90=AB=E6=9D=A5=E8=87=AA=E6=BA=90=E6=96=87=E4=BB=
=B6=E7=9A=84=E7=BB=93=E6=9E=84=E5=8C=96=E6=96=87=E6=A1=A3=E6=B3=A8=E9=87=8A
>  =E5=AE=89=E8=A3=85Sphinx
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -Documentation/ =E4=B8=8B=E7=9A=84ReST=E6=96=87=E4=BB=B6=E7=8E=B0=E5=9C=
=A8=E4=BD=BF=E7=94=A8sphinx1.3=E6=88=96=E6=9B=B4=E9=AB=98=E7=89=88=E6=9C=AC=
=E6=9E=84=E5=BB=BA=E3=80=82
> +Documentation/ =E4=B8=8B=E7=9A=84ReST=E6=96=87=E4=BB=B6=E7=8E=B0=E5=9C=
=A8=E4=BD=BF=E7=94=A8sphinx1.7=E6=88=96=E6=9B=B4=E9=AB=98=E7=89=88=E6=9C=AC=
=E6=9E=84=E5=BB=BA=E3=80=82
>
>  =E8=BF=99=E6=9C=89=E4=B8=80=E4=B8=AA=E8=84=9A=E6=9C=AC=E5=8F=AF=E4=BB=A5=
=E6=A3=80=E6=9F=A5Sphinx=E7=9A=84=E4=BE=9D=E8=B5=96=E9=A1=B9=E3=80=82=E6=9B=
=B4=E5=A4=9A=E8=AF=A6=E7=BB=86=E4=BF=A1=E6=81=AF=E8=A7=81
>  :ref:`sphinx-pre-install_zh` =E3=80=82
> @@ -40,22 +40,19 @@ Documentation/ =E4=B8=8B=E7=9A=84ReST=E6=96=87=E4=BB=
=B6=E7=8E=B0=E5=9C=A8=E4=BD=BF=E7=94=A8sphinx1.3=E6=88=96=E6=9B=B4=E9=AB=98=
=E7=89=88=E6=9C=AC=E6=9E=84=E5=BB=BA=E3=80=82
>
>  .. note::
>
> -   #) =E4=BD=8E=E4=BA=8E1.5=E7=89=88=E6=9C=AC=E7=9A=84Sphinx=E6=97=A0=E6=
=B3=95=E4=B8=8EPython=E7=9A=840.13.1=E6=88=96=E6=9B=B4=E9=AB=98=E7=89=88=E6=
=9C=ACdocutils=E4=B8=80=E8=B5=B7=E6=AD=A3=E5=B8=B8=E5=B7=A5=E4=BD=9C=E3=80=
=82
> -      =E5=A6=82=E6=9E=9C=E6=82=A8=E6=83=B3=E4=BD=BF=E7=94=A8=E8=BF=99=E4=
=BA=9B=E7=89=88=E6=9C=AC=EF=BC=8C=E9=82=A3=E4=B9=88=E5=BA=94=E8=AF=A5=E8=BF=
=90=E8=A1=8C ``pip install 'docutils=3D=3D0.12'`` =E3=80=82
> -
>     #) html=E8=BE=93=E5=87=BA=E5=BB=BA=E8=AE=AE=E4=BD=BF=E7=94=A8RTD=E4=
=B8=BB=E9=A2=98=E3=80=82=E6=A0=B9=E6=8D=AESphinx=E7=89=88=E6=9C=AC=E7=9A=84=
=E4=B8=8D=E5=90=8C=EF=BC=8C=E5=AE=83=E5=BA=94=E8=AF=A5=E7=94=A8
>        ``pip install sphinx_rtd_theme`` =E5=8D=95=E7=8B=AC=E5=AE=89=E8=A3=
=85=E3=80=82
>
>     #) =E4=B8=80=E4=BA=9BReST=E9=A1=B5=E9=9D=A2=E5=8C=85=E5=90=AB=E6=95=
=B0=E5=AD=A6=E8=A1=A8=E8=BE=BE=E5=BC=8F=E3=80=82=E7=94=B1=E4=BA=8ESphinx=E7=
=9A=84=E5=B7=A5=E4=BD=9C=E6=96=B9=E5=BC=8F=EF=BC=8C=E8=BF=99=E4=BA=9B=E8=A1=
=A8=E8=BE=BE=E5=BC=8F=E6=98=AF=E4=BD=BF=E7=94=A8 LaTeX
>        =E7=BC=96=E5=86=99=E7=9A=84=E3=80=82=E5=AE=83=E9=9C=80=E8=A6=81=E5=
=AE=89=E8=A3=85amsfonts=E5=92=8Camsmath=E5=AE=8F=E5=8C=85=EF=BC=8C=E4=BB=A5=
=E4=BE=BF=E6=98=BE=E7=A4=BA=E3=80=82
>
> -=E6=80=BB=E4=B9=8B=EF=BC=8C=E5=A6=82=E6=82=A8=E8=A6=81=E5=AE=89=E8=A3=85=
Sphinx 1.7.9=E7=89=88=E6=9C=AC=EF=BC=8C=E5=BA=94=E6=89=A7=E8=A1=8C::
> +=E6=80=BB=E4=B9=8B=EF=BC=8C=E5=A6=82=E6=82=A8=E8=A6=81=E5=AE=89=E8=A3=85=
Sphinx 2.4.4=E7=89=88=E6=9C=AC=EF=BC=8C=E5=BA=94=E6=89=A7=E8=A1=8C::
>
> -       $ virtualenv sphinx_1.7.9
> -       $ . sphinx_1.7.9/bin/activate
> -       (sphinx_1.7.9) $ pip install -r Documentation/sphinx/requirements=
.txt
> +       $ virtualenv sphinx_2.4.4
> +       $ . sphinx_2.4.4/bin/activate
> +       (sphinx_2.4.4) $ pip install -r Documentation/sphinx/requirements=
.txt
>
> -=E5=9C=A8=E8=BF=90=E8=A1=8C ``. sphinx_1.7.9/bin/activate`` =E4=B9=8B=E5=
=90=8E=EF=BC=8C=E6=8F=90=E7=A4=BA=E7=AC=A6=E5=B0=86=E5=8F=98=E5=8C=96=EF=BC=
=8C=E4=BB=A5=E6=8C=87=E7=A4=BA=E6=82=A8=E6=AD=A3=E5=9C=A8=E4=BD=BF=E7=94=A8=
=E6=96=B0
> +=E5=9C=A8=E8=BF=90=E8=A1=8C ``. sphinx_2.4.4/bin/activate`` =E4=B9=8B=E5=
=90=8E=EF=BC=8C=E6=8F=90=E7=A4=BA=E7=AC=A6=E5=B0=86=E5=8F=98=E5=8C=96=EF=BC=
=8C=E4=BB=A5=E6=8C=87=E7=A4=BA=E6=82=A8=E6=AD=A3=E5=9C=A8=E4=BD=BF=E7=94=A8=
=E6=96=B0
>  =E7=8E=AF=E5=A2=83=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E6=89=93=E5=BC=80=
=E4=BA=86=E4=B8=80=E4=B8=AA=E6=96=B0=E7=9A=84shell=EF=BC=8C=E9=82=A3=E4=B9=
=88=E5=9C=A8=E6=9E=84=E5=BB=BA=E6=96=87=E6=A1=A3=E4=B9=8B=E5=89=8D=EF=BC=8C=
=E6=82=A8=E9=9C=80=E8=A6=81=E9=87=8D=E6=96=B0=E8=BF=90=E8=A1=8C=E6=AD=A4=E5=
=91=BD=E4=BB=A4=E4=BB=A5=E5=86=8D
>  =E6=AC=A1=E8=BF=9B=E5=85=A5=E8=99=9A=E6=8B=9F=E7=8E=AF=E5=A2=83=E4=B8=AD=
=E3=80=82
>
> @@ -71,7 +68,7 @@ Documentation/ =E4=B8=8B=E7=9A=84ReST=E6=96=87=E4=BB=B6=
=E7=8E=B0=E5=9C=A8=E4=BD=BF=E7=94=A8sphinx1.3=E6=88=96=E6=9B=B4=E9=AB=98=E7=
=89=88=E6=9C=AC=E6=9E=84=E5=BB=BA=E3=80=82
>  PDF=E5=92=8CLaTeX=E6=9E=84=E5=BB=BA
>  --------------
>
> -=E7=9B=AE=E5=89=8D=E5=8F=AA=E6=9C=89Sphinx 1.4=E5=8F=8A=E6=9B=B4=E9=AB=
=98=E7=89=88=E6=9C=AC=E6=89=8D=E6=94=AF=E6=8C=81=E8=BF=99=E7=A7=8D=E6=9E=84=
=E5=BB=BA=E3=80=82
> +=E7=9B=AE=E5=89=8D=E5=8F=AA=E6=9C=89Sphinx 2.4=E5=8F=8A=E6=9B=B4=E9=AB=
=98=E7=89=88=E6=9C=AC=E6=89=8D=E6=94=AF=E6=8C=81=E8=BF=99=E7=A7=8D=E6=9E=84=
=E5=BB=BA=E3=80=82
>
>  =E5=AF=B9=E4=BA=8EPDF=E5=92=8CLaTeX=E8=BE=93=E5=87=BA=EF=BC=8C=E8=BF=98=
=E9=9C=80=E8=A6=81 ``XeLaTeX`` 3.14159265=E7=89=88=E6=9C=AC=E3=80=82=EF=BC=
=88=E8=AF=91=E6=B3=A8=EF=BC=9A=E6=AD=A4=E7=89=88=E6=9C=AC=E5=8F=B7=E7=9C=9F=
=E5=AE=9E
>  =E5=AD=98=E5=9C=A8=EF=BC=89
> @@ -93,8 +90,8 @@ PDF=E5=92=8CLaTeX=E6=9E=84=E5=BB=BA
>         You should run:
>
>                 sudo dnf install -y texlive-luatex85
> -               /usr/bin/virtualenv sphinx_1.7.9
> -               . sphinx_1.7.9/bin/activate
> +               /usr/bin/virtualenv sphinx_2.4.4
> +               . sphinx_2.4.4/bin/activate
>                 pip install -r Documentation/sphinx/requirements.txt
>
>         Can't build as 1 mandatory dependency is missing at ./scripts/sph=
inx-pre-install line 468.
>
> base-commit: 603bdf5d6c092eb05666decd84288dfda71eee90
> --
> 2.17.1
>
>
